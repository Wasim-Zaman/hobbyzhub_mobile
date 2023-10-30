// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/notification/notification_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
                  _settingModalBottomSheet(context);
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
                          width: 52.w,
                          //  height: 51.h,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 49.w,
                                  height: 60.h,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                  ),
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
                    return Padding(
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
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        width: 250.w,
                                        child: Text(
                                          'It is a long established fact that a read and will be distracted lisece.',
                                          maxLines: 2,
                                          style:
                                              AppTextStyle.listTileSubHeading,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Column(
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
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
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
