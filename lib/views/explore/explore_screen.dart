// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hobbyzhub/blocs/explore/explore_cubit.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/profile/third_person_profile_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/basic_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  /*
    * 0 - Explore
    * 1 - Users, Hobbyz
    * 2 - Searching
   */
  int screen = 0;
  late String userId;

  @override
  void initState() {
    ExploreCubit.get(context).getSubscribedHobbyz();
    UserSecureStorage.fetchUserId().then((value) {
      userId = value!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppbarWidget(title: 'Explore', isBackButton: true, actions: [
        IconButton(
          onPressed: () {
            // show searching results
            setState(() {
              screen = 2;
            });
          },
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ).visible(screen != 2),
      ]),
      body: screen == 0
          ? BlocConsumer<ExploreCubit, ExploreState>(
              listener: (context, state) {
                if (state is ExploreGetHobbyzPostsSuccess) {
                  ExploreCubit.get(context).hobbyzPosts = state.res.data;
                } else if (state is ExploreGetSubscribedHobbyzSuccess) {
                  ExploreCubit.get(context).hobbyz = state.res.data;
                } else if (state is ExploreGetHobbyzPostsSuccess) {
                  ExploreCubit.get(context).hobbyzPosts = state.res.data;
                  screen = 1;
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: HobbyItems(hobbies: [
                        'All',
                        ...ExploreCubit.get(context)
                            .hobbyz
                            .map((e) => e.categoryName ?? '')
                            .toList()
                      ]),
                    ),
                    16.height,
                    Expanded(
                      child: screen == 1
                          ? HobbyPostsWidget()
                          : RandomPeopleAndHobbyz(),
                    ),
                  ],
                );
              },
            )
          : screen == 2
              ? UsersListScreen(userId: userId)
              : SizedBox.shrink(),
    );
  }
}

class HobbyItems extends StatefulWidget {
  final List<String> hobbies;

  const HobbyItems({super.key, required this.hobbies});

  @override
  State<HobbyItems> createState() => _HobbyItemsState();
}

class _HobbyItemsState extends State<HobbyItems> {
  int selectedIndex = 0;
  var scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        // setState(() {
        //   selectedIndex = (selectedIndex + 1) % widget.hobbies.length;
        // });
        ExploreCubit.get(context).getMoreSubscribedHobbyz();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.hobbies.length,
      padding: EdgeInsets.symmetric(horizontal: 8),
      controller: scrollController,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(right: 8),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                selectedIndex = index;
              });
              ExploreCubit.get(context).getHobbyPosts(widget.hobbies[index]);
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color:
                    selectedIndex == index ? AppColors.primary : AppColors.grey,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: selectedIndex == index
                  ? AppColors.primary
                  : AppColors.transparent,
            ),
            child: Text(
              widget.hobbies[index],
              style: TextStyle(
                color: selectedIndex == index
                    ? AppColors.white
                    : AppColors.darkGrey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ).visible(index != 0);
      },
    );
  }
}

class RandomPeopleAndHobbyz extends StatefulWidget {
  const RandomPeopleAndHobbyz({Key? key}) : super(key: key);

  @override
  State<RandomPeopleAndHobbyz> createState() => _RandomPeopleAndHobbyzState();
}

class _RandomPeopleAndHobbyzState extends State<RandomPeopleAndHobbyz> {
  final ScrollController hobbiesScroll = ScrollController();
  final ScrollController usersScroll = ScrollController();

  @override
  void initState() {
    super.initState();

    ExploreCubit.get(context).getRandomPosts();
    ExploreCubit.get(context).getRandomUsers();

    hobbiesScroll.addListener(() {
      if (hobbiesScroll.position.pixels ==
          hobbiesScroll.position.maxScrollExtent) {
        ExploreCubit.get(context).getMoreRandomPosts();
      }
    });
    usersScroll.addListener(() {
      if (usersScroll.position.pixels == usersScroll.position.maxScrollExtent) {
        ExploreCubit.get(context).getMoreRandomUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Users Section
          Text("People", style: AppTextStyle.subHeading),
          10.height,
          BlocConsumer<ExploreCubit, ExploreState>(
            listener: (context, state) {
              if (state is ExploreGetRandomUsersSuccess) {
                ExploreCubit.get(context).users = state.res.data;
              } else if (state is ExploreGetMoreRandomUsersSuccess) {
                ExploreCubit.get(context).users.addAll(state.res.data);
              }
            },
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: usersScroll,
                  itemBuilder: (context, index) {
                    if (index == ExploreCubit.get(context).users.length) {
                      return Center(
                        child: LoadingWidget(),
                      ).visible(state is ExploreGetMoreRandomUsersLoading);
                    }
                    var user = ExploreCubit.get(context).users[index];
                    return GestureDetector(
                      onTap: () {
                        AppNavigator.goToPage(
                          context: context,
                          screen: ThirdPersonProfileScreen(
                            userId: user.userId.toString(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10.w),
                        child: GridTile(
                          // footer: GridTileBar(
                          //   title: Text(user.fullName ?? ''),
                          //   backgroundColor: Colors.black.withOpacity(0.5),
                          // ),
                          child: CachedNetworkImage(
                            imageUrl: user.profileImage ?? '',
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: ExploreCubit.get(context).users.length + 1,
                ),
              );
            },
          ),
          20.height,
          // Posts Section
          Text("Hobbies", style: AppTextStyle.subHeading),
          10.height,
          BlocConsumer<ExploreCubit, ExploreState>(
            listener: (context, state) {
              if (state is ExploreGetRandomPostsSuccess) {
                ExploreCubit.get(context).posts = state.res.data;
              } else if (state is ExploreGetMoreRandomPostsSuccess) {
                ExploreCubit.get(context).posts.addAll(state.res.data);
              } else if (state is ExploreGetRandomPostsError) {
                print(state.message);
              }
            },
            builder: (context, state) {
              return Expanded(
                  flex: 3,
                  child: MasonryGridView.count(
                    controller: hobbiesScroll,
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    itemBuilder: (context, index) {
                      var post = ExploreCubit.get(context).posts[index];
                      return GridTile(
                        child: CachedNetworkImage(
                          imageUrl: post.imageUrls!.first,
                        ),
                      );
                    },
                    itemCount: ExploreCubit.get(context).posts.length,
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class HobbyPostsWidget extends StatefulWidget {
  const HobbyPostsWidget({Key? key}) : super(key: key);

  @override
  State<HobbyPostsWidget> createState() => _HobbyPostsWidgetState();
}

class _HobbyPostsWidgetState extends State<HobbyPostsWidget> {
  var postsScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Posts", style: AppTextStyle.subHeading),
        10.height,
        BlocConsumer<ExploreCubit, ExploreState>(
          listener: (context, state) {
            if (state is ExploreGetHobbyzPostsSuccess) {
              ExploreCubit.get(context).hobbyzPosts = state.res.data;
            } else if (state is ExploreGetMoreHobbyzPostsSuccess) {
              ExploreCubit.get(context).hobbyzPosts.addAll(state.res.data);
            }
          },
          builder: (context, state) {
            return Expanded(
                child: MasonryGridView.count(
              controller: postsScroll,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                var post = ExploreCubit.get(context).hobbyzPosts[index];
                return GridTile(
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrls!.first,
                  ),
                );
              },
              itemCount: ExploreCubit.get(context).hobbyzPosts.length,
            ));
          },
        ),
      ],
    );
  }
}

class UsersListScreen extends StatefulWidget {
  final String userId;
  const UsersListScreen({super.key, required this.userId});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  var searchedUsers = <User>[];
  // UserBloc userBloc = UserBloc();
  var scrollController = ScrollController();

  String slug = '';
  int page = 0;
  int pageSize = 20;

  @override
  void initState() {
    searchUserInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        searchUserMore();
      }
    });
    super.initState();
  }

  searchUserInit() {
    // slug = '';
    context.read<UserBloc>().add(
          UserSearchByNameEvent(slug: slug, page: page, pageSize: pageSize),
        );
  }

  searchUserMore() {
    page = page + 1;
    context.read<UserBloc>().add(
          UserSearchByNameMoreEvent(slug: slug, page: page, pageSize: pageSize),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) {
              slug = value;
              searchUserInit();
            },
            decoration: InputDecoration(
              prefixIcon: Icon(LineIcons.search),
            ),
          ),
          10.height,
          Text("Search Results"),
          10.height,
          Expanded(
            child: BlocConsumer<UserBloc, UserState>(
              // bloc: userBloc,
              listener: (context, state) {
                if (state is UserSearchByNameLoading) {
                  searchedUsers.clear();
                } else if (state is UserSearchByNameSuccess) {
                  searchedUsers = state.users;
                } else if (state is UserSearchByNameMoreSuccess) {
                  searchedUsers.addAll(state.users);
                }
              },
              builder: (context, state) {
                if (state is UserSearchByNameLoading) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                } else if (state is UserSearchByNameFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return ListView.builder(
                    // controller: searchedUserController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: searchedUsers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          AppNavigator.goToPage(
                              context: context,
                              screen: ThirdPersonProfileScreen(
                                userId: searchedUsers[index].userId.toString(),
                              ));
                        },
                        leading: SizedBox(
                          width: 45.w,
                          height: 45.h,
                          child: Stack(
                            children: [
                              Container(
                                width: 45.w,
                                height: 45.h,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        searchedUsers[index]
                                            .profileImage
                                            .toString(), errorListener: (_) {
                                      print("error");
                                    }),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              // Positioned(
                              //   left: 35,
                              //   top: 36,
                              //   child: Container(
                              //     width: 12,
                              //     height: 12,
                              //     decoration: ShapeDecoration(
                              //       color: Color(0xFF12B669),
                              //       shape: OvalBorder(),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        title: Text(
                          searchedUsers[index].fullName.toString(),
                          style: AppTextStyle.listTileTitle,
                        ),
                        // subtitle: Text(
                        //   'Last Active 3 hours',
                        //   style: AppTextStyle.listTileSubHeading,
                        // ),
                        // trailing: TextButton(
                        //   onPressed: () {
                        //     ChatCubit.get(context).createPrivateChat(
                        //       searchedUsers[index].userId.toString(),
                        //     );
                        //   },
                        //   child: const Text('Start Chat'),
                        // ),
                      ).visible(searchedUsers[index].userId != widget.userId);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
