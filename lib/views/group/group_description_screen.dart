import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/controllers/group/group_controller.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/group/add_group_members.dart';
import 'package:hobbyzhub/views/group/group_members_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class GroupDescriptionScreen extends StatefulWidget {
  final GroupChat group;
  const GroupDescriptionScreen({super.key, required this.group});

  @override
  State<GroupDescriptionScreen> createState() => _GroupDescriptionScreenState();
}

class _GroupDescriptionScreenState extends State<GroupDescriptionScreen> {
  // Blocs
  late UserBloc userBloc;

  // Controllers
  ScrollController searchedUserController = ScrollController();

  // Pagination
  int page = 0;
  int pageSize = 20;

  // Others
  String slug = '';
  GroupChat? group;

  // Lists
  List<User> searchedUsers = [];

  @override
  void initState() {
    group = widget.group;
    userBloc = BlocProvider.of<UserBloc>(context);

    searchedUserController.addListener(() {
      // when we scroll all users then increase the page size by 1 and call searchMoreUser function
      if (searchedUserController.position.pixels ==
          searchedUserController.position.maxScrollExtent) {
        page = page + 1;
        searchUserMore();
      }
    });
    super.initState();
  }

  searchUserInit() {
    slug = '';
    userBloc.add(
      UserSearchByNameEvent(slug: slug, page: page, pageSize: pageSize),
    );
  }

  searchUserMore() {
    userBloc.add(
      UserSearchByNameMoreEvent(slug: slug, page: page, pageSize: pageSize),
    );
  }

  void _searchBottomSheet(context, {required UserType userType}) {
    searchUserInit();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        useSafeArea: true,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.6,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 25.h,
                    child: TextField(
                      onChanged: (value) {
                        slug = value;
                        searchUserInit();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        hintText: "Search",
                        hintStyle: AppTextStyle.listTileSubHeading,
                        prefixIcon: Image.asset(
                          ImageAssets.searchImage,
                          height: 10.h,
                          width: 10.w,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: BlocConsumer<UserBloc, UserState>(
                    bloc: userBloc,
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
                          controller: searchedUserController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: searchedUsers.length,
                          itemBuilder: (context, index) {
                            return AddUserTile(
                              user: searchedUsers[index],
                              chatId: widget.group.room!,
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupGetDetailsState) {
            // group = state.group;
          }
        },
        builder: (context, state) {
          return group == null
              ? const Center(child: LoadingWidget())
              : StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('group-chats')
                      .where('room', isEqualTo: widget.group.room.toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    // I know that this snpshot will always be one
                    // so take it and assign it to the group

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LoadingWidget());
                    }
                    group = GroupChat.fromJson(snapshot.data?.docs.first.data()
                        as Map<String, dynamic>);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Group Image Section
                          Container(
                            height: context.height() * 0.3,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: ImageWidget(
                                      imageUrl: group?.groupImage ?? '',
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                16.height,
                                Text(
                                  group?.title ?? '',
                                  style: AppTextStyle.headings,
                                ),
                                Text("Public Group",
                                    style: AppTextStyle.normal),
                              ],
                            ),
                          ),
                          // Group Details Section
                          Text("Description", style: AppTextStyle.button),
                          8.height,
                          Text(group!.groupDescription!,
                              style: AppTextStyle.normal),
                          const Divider(),
                          // Add member
                          ListTile(
                            onTap: () {
                              _searchBottomSheet(context,
                                  userType: UserType.member);
                            },
                            leading: const Icon(
                              Icons.group_add_outlined,
                              color: AppColors.primary,
                            ),
                            title:
                                Text("Add Member", style: AppTextStyle.normal),
                          ),
                          // Members
                          ListTile(
                            onTap: () {
                              AppNavigator.goToPage(
                                context: context,
                                screen: GroupMembersScreen(
                                  group: group,
                                ),
                              );
                            },
                            leading: const Icon(
                              Icons.group_outlined,
                              color: AppColors.primary,
                            ),
                            title: Text("Members", style: AppTextStyle.normal),
                            trailing: Text(
                              "${group!.participants!.length}",
                              style: AppTextStyle.button,
                            ),
                          ),
                          // Administrations
                          // ListTile(
                          //   leading: const Icon(
                          //     Icons.admin_panel_settings_outlined,
                          //     color: AppColors.primary,
                          //   ),
                          //   title: Text("Administrators",
                          //       style: AppTextStyle.normal),
                          //   trailing: Text(
                          //     "${group!.adminIds!.length}",
                          //     style: AppTextStyle.button,
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}

class AddUserTile extends StatefulWidget {
  final User user;
  final String chatId;
  const AddUserTile({Key? key, required this.user, required this.chatId})
      : super(key: key);

  @override
  State<AddUserTile> createState() => _AddUserTileState();
}

class _AddUserTileState extends State<AddUserTile> {
  bool isAdded = false;
  String? userId;

  @override
  void initState() {
    UserSecureStorage.fetchUserId().then((value) {
      userId = value;
    });
    super.initState();
  }

  addMember(String chatId, String memberId) {
    context.read<GroupBloc>().add(GroupAddMemberEvent(
          chatId: chatId,
          memberId: memberId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
                  image: NetworkImage(
                    widget.user.profileImage.toString(),
                  ),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Text(
        widget.user.fullName.toString(),
        style: AppTextStyle.listTileTitle,
      ),
      // subtitle: Text(
      //   'Last Active 3 hours',
      //   style: AppTextStyle.listTileSubHeading,
      // ),
      trailing: TextButton(
          onPressed: () async {
            // addMember(widget.chatId, widget.user.userId!);
            if (!isAdded) {
              await GroupController().addMemberToTheGroup(
                groupChatId: widget.chatId,
                memberId: widget.user.userId!,
              );

              setState(() {
                isAdded = true;
                context
                    .read<GroupBloc>()
                    .add(GroupGetDetailsEvent(chatId: widget.chatId));
              });
            }
          },
          child: Text(
            isAdded ? "Added" : "Add",
            style: AppTextStyle.button,
          )),
    ).visible(widget.user.userId != userId);
  }
}
