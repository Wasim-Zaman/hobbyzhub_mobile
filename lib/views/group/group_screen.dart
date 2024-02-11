// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/group/group_model.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/group/create_group_screen.dart';
import 'package:hobbyzhub/views/group/group_messaging_screen.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<GroupModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Groups", style: AppTextStyle.headings),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  // _searchBottomSheet(context);
                },
                child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      ImageAssets.searchImage,
                      height: 25.h,
                    )),
              ),
              GestureDetector(
                onTap: () {
                  AppNavigator.goToPage(
                    context: context,
                    screen: CreateGroupScreen(),
                  );
                },
                child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.asset(
                      ImageAssets.newGroupImage,
                      height: 25.h,
                    )),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupGetChatsState) {
            groups = state.chats;
          } else if (state is GroupErrorState) {}
        },
        builder: (context, state) {
          if (state is GroupLoadingState) {
            return Center(
              child: LoadingWidget(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: groups.length,
                    padding:
                        EdgeInsets.only(top: 10.h, left: 10.h, right: 10.h),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          AppNavigator.goToPage(
                            context: context,
                            screen: GroupMessagingScreen(group: groups[index]),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            color: AppColors.lightGrey,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 20.h,
                                  bottom: 20.h,
                                  left: 5.w,
                                  right: 5.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
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
                                                    groups[index].groupIcon ??
                                                        "https://via.placeholder.com/44x45",
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
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
                                              groups[index].groupName ?? '',
                                              style: AppTextStyle.listTileTitle,
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              width: 230.w,
                                              child: Text(
                                                groups[index]
                                                        .groupDescription ??
                                                    '',
                                                maxLines: 2,
                                                style: AppTextStyle
                                                    .listTileSubHeading,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.center,
                                      //     children: [
                                      //       Container(
                                      //         width: 20.w,
                                      //         height: 20.h,
                                      //         decoration: ShapeDecoration(
                                      //           color: Color(0xFF26A4FF),
                                      //           shape: OvalBorder(),
                                      //         ),
                                      //         child: Center(
                                      //           child: Text(
                                      //             '',
                                      //             textAlign: TextAlign.center,
                                      //             style: AppTextStyle
                                      //                 .subcategorySelectedTextStyle,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // )
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
          );
        },
      ),
    );
  }
}

void searchBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
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
                                      width: 47.w,
                                      height: 48.h,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            child: Container(
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
                                          ),
                                          Positioned(
                                            left: 35,
                                            top: 36,
                                            child: Container(
                                              width: 12,
                                              height: 12,
                                              decoration: ShapeDecoration(
                                                color: Color(0xFF12B669),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 19.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Jane Smith',
                                          style: AppTextStyle.listTileTitle,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        SizedBox(
                                          width: 250.w,
                                          child: Text(
                                            'Last Active 3 hours',
                                            style:
                                                AppTextStyle.listTileSubHeading,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 70.88,
                                          height: 30.96,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF0195F7),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(80),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Follow',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.93,
                                                  fontFamily: 'Jost',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      });
}
