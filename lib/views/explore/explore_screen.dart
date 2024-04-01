// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
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
    UserSecureStorage.fetchUserId().then((value) {
      userId = value!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          BasicAppbarWidget(title: 'Explore', isBackButton: false, actions: [
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
      body: screen == 2
          ? UsersListScreen(userId: userId)
          : Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: ListView.builder(
                            //  controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0x2D3C3C43)),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Art',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.dialogNormal),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'People',
                        style: AppTextStyle.exploreSubHead,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 130.h,
                        child: ListView.builder(
                            // controller: scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: Container(
                                  width: 100.w,
                                  height: 130.h,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: double.infinity,
                                      height: 20.h,
                                      color: Color(0xCCD9D9D9),
                                      child: Text(
                                        '@tom_lee',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.dialogNormal,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Hobbies',
                        style: AppTextStyle.exploreSubHead,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        children: List<Widget>.generate(25, (index) {
                          return GridTile(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 0.5, color: Colors.grey),
              ),
              prefixIcon: Image.asset(
                ImageAssets.searchImage,
                height: 10,
              ),
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
                        onTap: () {},
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
