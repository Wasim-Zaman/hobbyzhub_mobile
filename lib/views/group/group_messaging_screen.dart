// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class GroupMessagingScreen extends StatefulWidget {
  const GroupMessagingScreen({super.key});

  @override
  State<GroupMessagingScreen> createState() => _GroupMessagingScreenState();
}

class _GroupMessagingScreenState extends State<GroupMessagingScreen> {
  void handleClick(int value) {
    switch (value) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  side:
                      const BorderSide(width: 1.5, color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Center(
                child: Icon(
                  Ionicons.arrow_back,
                  size: 20.sp,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width / 1.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      'Friends Community',
                      style: AppTextStyle.listTileTitle,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '210 members',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subcategoryUnSelectedTextStyle,
                  )
                ],
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            elevation: 1,
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                // row with two children
                child: Row(
                  children: [
                    Icon(Ionicons.refresh),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Clear Chat',
                      style: AppTextStyle.listTileSubHeading,
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.delete_outline_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Delete Chat',
                      style: AppTextStyle.listTileSubHeading,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                // row with two children
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.exportImage,
                      height: 30.h,
                      width: 30.h,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Export Chat',
                      style: AppTextStyle.listTileSubHeading,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 12.w, left: 12.w, right: 12.w),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 56.h,
                padding: const EdgeInsets.only(
                  left: 22,
                ),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x21000000),
                      blurRadius: 20,
                      offset: Offset(5, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.attach_file),
                        SizedBox(width: 10.w),
                        Text(
                          'Write your message',
                          style: AppTextStyle.subcategoryUnSelectedTextStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Icon(
                        Icons.send,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                  width: 55.w,
                  height: 56.h,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x21000000),
                        blurRadius: 20,
                        offset: Offset(5, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_outlined,
                    ),
                  )),
            ],
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          itemBuilder: (context, inde) {
            return Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 268.w,
                          height: 72.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 42.w, vertical: 27.h),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0xFF26A4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(41.80),
                                topRight: Radius.circular(41.80),
                                bottomLeft: Radius.circular(41.80),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 184.w,
                                child: Text(
                                  'Hello man how are you doing?',
                                  textAlign: TextAlign.right,
                                  style:
                                      AppTextStyle.subcategorySelectedTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '12:10',
                          textAlign: TextAlign.right,
                          style: AppTextStyle.subcategoryUnSelectedTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 268.w,
                          height: 72.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 42.w, vertical: 27.h),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Color(0x1926A4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(41.80),
                                topRight: Radius.circular(41.80),
                                bottomRight: Radius.circular(41.80),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 184,
                                child: Text(
                                  'I’m fine bro how are you?',
                                  style: AppTextStyle
                                      .subcategoryUnSelectedTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          '12:10',
                          textAlign: TextAlign.right,
                          style: AppTextStyle.subcategoryUnSelectedTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
