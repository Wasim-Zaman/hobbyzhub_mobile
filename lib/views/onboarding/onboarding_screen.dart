// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/onboarding/dine_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();

    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.r),
        ),
        color: _currentPage == index ? AppColors.primary : Colors.grey.shade400,
      ),
      margin: EdgeInsets.only(right: 5.w),
      height: 10.h,
      curve: Curves.easeIn,
      width: _currentPage == index ? 30.w : 10.w,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Expanded(
              flex: 3,
              child: Image.asset(
                contents[_currentPage].image,
                width: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
            Expanded(
              flex: 2,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(contents[i].title,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.headings),
                        SizedBox(height: 10.h),
                        Text(contents[i].subtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.subHeading),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (int index) => _buildDots(
                            index: index,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: PrimaryButtonWidget(
                            width: MediaQuery.of(context).size.width / 2,
                            caption: 'Next',
                            onPressed: () {
                              if (_currentPage == 2) {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (builder) => DineScreen()),
                                    (route) => false);
                              } else {
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );
                              }
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String title;
  final String subtitle;

  final String image;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

List<OnboardingModel> contents = [
  OnboardingModel(
      title: "Discover Your Passions",
      image: ImageAssets.onboardingImage,
      subtitle:
          "Ready to explore a universe of hobbies? Hobbyzhub invites you to embark on a journey of discovery, where your interests come alive"),
  OnboardingModel(
      title: "Connect with Enthusiasts",
      image: ImageAssets.onboarding3Image,
      subtitle:
          "Ready to explore a universe of hobbies? Hobbyzhub invites you to embark on a journey of discovery, where your interests come alive"),
  OnboardingModel(
      title: "Unleash Your Creativity",
      image: ImageAssets.onboarding2Image,
      subtitle:
          "Ready to explore a universe of hobbies? Hobbyzhub invites you to embark on a journey of discovery, where your interests come alive"),
];
