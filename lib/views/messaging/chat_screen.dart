// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/notification/notification_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

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
                  AppNavigator.goToPage(
                    context: context,
                    screen: const NotificationScreen(),
                  );
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
            Container(
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
                        Container(
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
                    return Container(
                      color: AppColors.lightGrey,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 20.h, left: 10.w, right: 10.w),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Jane Smith',
                                      style: TextStyle(
                                        color: Color(0xFF35364F),
                                        fontSize: 12.32,
                                        fontFamily: 'Jost',
                                        fontWeight: FontWeight.w500,
                                        height: 0.19,
                                        letterSpacing: 0.25,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SizedBox(
                                      width: 250.w,
                                      child: Text(
                                        'It is a long established fact that a read and will be distracted lisece.',
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Color(0x9E35354F),
                                          fontSize: 11.44,
                                          fontFamily: 'Jost',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '22.51',
                                      style: TextStyle(
                                        color: Color(0x8E35354F),
                                        fontSize: 10.56,
                                        fontFamily: 'Jost',
                                        fontWeight: FontWeight.w500,
                                        height: 0.25,
                                        letterSpacing: 0.21,
                                      ),
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
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
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
