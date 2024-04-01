// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/private/private_chat_cubit.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/bottom_nav_bar/main_tabs_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

enum UserType { member, admin }

class AddGroupMembers extends StatefulWidget {
  final String groupName, groupDescription;
  final File? groupImage;
  const AddGroupMembers({
    super.key,
    required this.groupName,
    required this.groupDescription,
    this.groupImage,
  });

  @override
  State<AddGroupMembers> createState() => _AddGroupMembersState();
}

class _AddGroupMembersState extends State<AddGroupMembers> {
  // Blocs
  late UserBloc userBloc;

  // Lists
  List<User> searchedUsers = [];
  List<User> members = [];
  List<User> admins = [];

  // Controllers
  ScrollController searchedUserController = ScrollController();

  // Pagination
  int page = 0;
  int pageSize = 20;

  // Others
  String slug = '';
  String? userId;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    UserSecureStorage.fetchUserId().then((value) {
      userId = value;
    });
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
            decoration: BoxDecoration(
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
                        contentPadding: EdgeInsets.all(0),
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
                Divider(),
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
                        if (userType == UserType.admin) {
                          searchedUsers = members;
                        } else {
                          searchedUsers = state.users;
                        }
                      } else if (state is UserSearchByNameMoreSuccess) {
                        searchedUsers.addAll(state.users);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserSearchByNameLoading) {
                        return Center(
                          child: LoadingWidget(),
                        );
                      } else if (state is UserSearchByNameFailure) {
                        return Center(
                          child: Text(state.message),
                        );
                      }

                      return ListView.builder(
                          controller: searchedUserController,
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: searchedUsers.length,
                          itemBuilder: (context, index) {
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
                                            searchedUsers[index]
                                                .profileImage
                                                .toString(),
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
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
                              trailing: TextButton(
                                onPressed: () {
                                  // add member
                                  if (userType == UserType.member) {
                                    print('Member added');
                                    // check if that user already exists or not.
                                    if (!members
                                        .contains(searchedUsers[index])) {
                                      setState(() {
                                        members.insert(0, searchedUsers[index]);
                                      });
                                    } else {
                                      toast("User already added");
                                    }
                                  } else if (userType == UserType.admin) {
                                    print('admin added');
                                    // if the admin already exists in the admin list, do not add it again
                                    if (!admins
                                        .contains(searchedUsers[index])) {
                                      setState(() {
                                        admins.insert(0, searchedUsers[index]);
                                      });
                                    } else {
                                      toast("Admin already added");
                                    }
                                  }
                                },
                                child: Text('Add'),
                              ),
                            ).visible(searchedUsers[index].userId != userId);
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
      backgroundColor: Colors.white,
      appBar: BackAppbarWidget(),
      body: BlocListener<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatCreateGroupLoading) {
            AppDialogs.loadingDialog(context);
          } else if (state is ChatCreateGroupSuccess) {
            AppDialogs.closeDialog(context);
            Future.delayed(Duration(milliseconds: 500)).then((value) {
              groupCreationSheet(context, group: state.group);
            });
          } else if (state is ChatCreateGroupError) {
            AppDialogs.closeDialog(context);
            toast(state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: Text(
                  'Group Admin',
                  style: TextStyle(
                    color: Color(0xFF181818),
                    fontSize: 24,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              30.height,
              Expanded(
                child: Wrap(
                  children: [
                    ...admins
                        .map((e) => Stack(
                              children: [
                                Container(
                                  width: 70.w,
                                  height: 70.h,
                                  margin: const EdgeInsets.only(
                                    right: 16,
                                    bottom: 16,
                                  ),
                                  decoration: ShapeDecoration(
                                    shape: OvalBorder(),
                                  ),
                                  child: ClipOval(
                                    child: ImageWidget(
                                      imageUrl: e.profileImage.toString(),
                                      height: 70.h,
                                      width: 70.w,
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          Image.asset(ImageAssets.profileImage),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 46.w,
                                  top: 46.h,
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF0F3F5),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.50, color: Colors.white),
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        // remove that instance
                                        setState(() {
                                          admins.remove(e);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                    GestureDetector(
                      onTap: () {
                        // show user search sheet
                        _searchBottomSheet(context, userType: UserType.admin);
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(ImageAssets.addNewPersonImage),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.height,
              SizedBox(
                child: Text(
                  'Add Members',
                  style: TextStyle(
                    color: Color(0xFF181818),
                    fontSize: 24,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              20.height,
              Expanded(
                flex: 3,
                child: Wrap(
                  children: [
                    ...members
                        .map((e) => Stack(
                              children: [
                                Container(
                                  width: 70.w,
                                  height: 70.h,
                                  margin: const EdgeInsets.only(
                                    right: 16,
                                    bottom: 16,
                                  ),
                                  decoration: ShapeDecoration(
                                    shape: OvalBorder(),
                                  ),
                                  child: ClipOval(
                                    child: ImageWidget(
                                      imageUrl: e.profileImage.toString(),
                                      height: 70.h,
                                      width: 70.w,
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          Image.asset(ImageAssets.profileImage),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 46.w,
                                  top: 46.h,
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF0F3F5),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                            width: 1.50, color: Colors.white),
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          members.remove(e);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                        .toList(),
                    GestureDetector(
                      onTap: () {
                        // show user search sheet
                        _searchBottomSheet(context, userType: UserType.member);
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(ImageAssets.addNewPersonImage),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PrimaryButtonWidget(
                caption: "Finish",
                onPressed: () {
                  createGroup();
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createGroup() {
    var body = {
      "title": widget.groupName,
      "groupDescription": widget.groupDescription,
      "participantRequests": [
        {"userId": userId.toString()},
        ...members.map((e) => {"userId": e.userId.toString()}).toList(),
      ],
      "adminIds": [
        {"userId": userId.toString()},
        ...admins.map((e) => {"userId": e.userId.toString()}).toList(),
      ],
      "groupImage": widget.groupImage,
    };
    // context.read<GroupBloc>().add(GroupCreateEvent(body: body));
    ChatCubit.get(context).createGroupChat(body);
  }
}

void groupCreationSheet(context, {required GroupChat group}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.all(50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // ImageWidget(imageUrl: group.groupIcon.toString()),
              Image.asset(ImageAssets.groupCreationImage),
              Text(
                group.title.toString(),
                style: TextStyle(
                  color: Color(0xFF394851),
                  fontSize: 24,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Text(
                'You Have Successfully Created a Group!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF777A95),
                  fontSize: 20,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              PrimaryButtonWidget(
                caption: "Continue",
                onPressed: () async {
                  // close the sheet
                  Navigator.pop(context);
                  await Future.delayed(Duration(milliseconds: 500));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainTabScreen(index: 1),
                      ),
                      (route) => false);
                },
              ),
            ],
          ),
        );
      });
}
