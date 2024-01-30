// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/messaging/messaging_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Blocs
  UserBloc userBloc = UserBloc();

  // Lists
  List<User> searchedUsers = [];

  // Controllers
  ScrollController searchedUserController = ScrollController();

  // Pagination
  int page = 0;
  int pageSize = 2;

  // Others
  String slug = '';

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Chat", style: AppTextStyle.headings),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _searchBottomSheet(context);
                },
                child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      ImageAssets.searchImage,
                      height: 25.h,
                    )),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      ImageAssets.addNewMessageImage,
                      height: 25.h,
                    )),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Frequently Chatted',
              style: AppTextStyle.exploreSubHead,
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 70.h,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 50.w,
                          //  height: 51.h,
                          child: Stack(
                            children: [
                              Container(
                                width: 49.w,
                                height: 60.h,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r)),
                                ),
                              ),
                              Positioned(
                                left: 40.w,
                                top: 50.h,
                                child: Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF12B669),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'All Messages',
              style: AppTextStyle.exploreSubHead,
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        AppNavigator.goToPage(
                          context: context,
                          screen: MessagingScreen(
                            userId: "",
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          color: AppColors.lightGrey,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.h, bottom: 20.h, left: 5.w, right: 5.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10.h,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 45.w,
                                            height: 45.h,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://via.placeholder.com/44x45"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 35.w,
                                            top: 33.h,
                                            child: Container(
                                              width: 12.w,
                                              height: 12.h,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF12B669),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Jane Smith',
                                            style: AppTextStyle.listTileTitle,
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          SizedBox(
                                            width: 250.w,
                                            child: Text(
                                              'It is a long established fact that a read and will be distracted lisece.',
                                              maxLines: 2,
                                              style: AppTextStyle
                                                  .listTileSubHeading,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '22.51',
                                            style: AppTextStyle.likeByTextStyle,
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Container(
                                            width: 20.w,
                                            height: 20.h,
                                            decoration: ShapeDecoration(
                                              color: Color(0xFF26A4FF),
                                              shape: OvalBorder(),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '3',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle
                                                    .subcategorySelectedTextStyle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  void _searchBottomSheet(context) {
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
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
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
                        searchedUsers = state.users;
                      } else if (state is UserSearchByNameMoreSuccess) {
                        searchedUsers.addAll(state.users);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserSearchByNameLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
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
                                onTap: () {
                                  AppNavigator.goToPage(
                                    context: context,
                                    screen: MessagingScreen(
                                      userId: searchedUsers[index]
                                          .userId
                                          .toString(),
                                    ),
                                  );
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
                                trailing: TextButton(
                                  onPressed: () {},
                                  child: Text('Start Chat'),
                                ));
                          });
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
