// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/welcome/welcome_screen.dart';

class DineScreen extends StatefulWidget {
  const DineScreen({super.key});

  @override
  State<DineScreen> createState() => _DineScreenState();
}

class _DineScreenState extends State<DineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Colors.white.withOpacity(0), Color(0xFF26A4FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  ImageAssets.appLogoImage,
                  width: 200.w,
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 20.h,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Welcome to Hobbyzhub",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.headings),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                            "Discover, explore, and share your passions with fellow hobbyists.Let the adventure begin!",
                            textAlign: TextAlign.center,
                            style: AppTextStyle.subHeading),
                        Padding(
                            padding: EdgeInsets.all(20.w),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) => WelcomeScreen()));
                              },
                              child: Container(
                                height: 60.h,
                                width: 200.w,
                                decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.primary,
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
