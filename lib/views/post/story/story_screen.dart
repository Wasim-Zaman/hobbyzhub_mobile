// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';

class StoryScreen extends StatefulWidget {
  const StoryScreen({super.key});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://img.freepik.com/premium-photo/abstract-black-textured-background-with-scratches_130265-12474.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 14.w,
              top: 47.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50.w,
                    height: 50.h,
                    child: Stack(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: OvalBorder(),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          'Jessica Felicio',
                          style: AppTextStyle.storyTitleTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 100.h,
                        child: Text(
                          '1hr ago',
                          style: AppTextStyle.subcategorySelectedTextStyle,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 14.w,
              top: 16.h,
              child: SizedBox(
                width: MediaQuery.of(context).size.height,
                height: 7.04,
                child: Stack(
                  children: [
                    Container(
                      width: 180.w,
                      height: 7.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                    ),
                    Positioned(
                      left: 190.w,
                      child: SizedBox(
                        width: 200.w,
                        height: 7.04.h,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0.04,
                              child: Container(
                                width: 200.w,
                                height: 7.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.04.h,
                              child: Container(
                                width: 98.42.w,
                                height: 7.h,
                                decoration: ShapeDecoration(
                                  color: Color(0x7F26A4FF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14.w,
              top: MediaQuery.of(context).size.height - 130.h,
              child: Container(
                  decoration: ShapeDecoration(
                    color: Color(0x7FCBCBCB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 14,
                        offset: Offset(0, 6),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width - 30.h,
                  height: 48.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: Icon(CupertinoIcons.heart)),
                      Expanded(child: Icon(CupertinoIcons.share)),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
