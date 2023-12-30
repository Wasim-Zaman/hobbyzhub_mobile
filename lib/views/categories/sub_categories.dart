// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:nb_utils/nb_utils.dart';

class SubCategoryScreen extends StatefulWidget {
  final List selectedCategories;
  const SubCategoryScreen({Key? key, required this.selectedCategories})
      : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.w, color: Color(0x33A0A2B3)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              width: 30.w,
              height: 30.h,
              child: Center(
                child: Icon(
                  Icons.navigate_before,
                  size: 30.sp,
                ),
              ),
            ),
          ),
        ),
        title:
            Center(child: Text('Sub-categories', style: AppTextStyle.headings)),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Icon(
              Icons.search,
              size: 30.sp,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.height,
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Container(
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 15,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.network(
                            "https://vectips.com/wp-content/uploads/2017/03/project-preview-large-2.png",
                            height: 45.w,
                          ),
                          20.width,
                          Text('Hikking', style: AppTextStyle.subHeading)
                        ],
                      ),
                      10.height,
                      Wrap(
                        alignment: WrapAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6),
                              child: Text('Day Hiking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategorySelectedTextStyle)),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.borderGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6.w),
                              child: Text('Backpacking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategoryUnSelectedTextStyle)),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6.w),
                              child: Text('Fastpacking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategorySelectedTextStyle)),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.borderGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6.w),
                              child: Text('Backpacking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategoryUnSelectedTextStyle)),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6.w),
                              child: Text('Fastpacking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategorySelectedTextStyle)),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.borderGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6.w),
                              child: Text('Backpacking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategoryUnSelectedTextStyle)),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: AppColors.borderGrey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              margin: EdgeInsets.all(6.w),
                              child: Text('Backpacking',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle
                                      .subcategoryUnSelectedTextStyle)),
                        ],
                      )
                    ],
                  ).paddingAll(16.w),
                ),
              );
            },
          )),
          SizedBox(
            height: 20.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PrimaryButtonWidget(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                onPressed: () {},
                caption: 'Finish Registration',
              ),
              SizedBox(
                height: 20.h,
              ),
              Text('Skip for now',
                  textAlign: TextAlign.center, style: AppTextStyle.subHeading)
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ).paddingAll(8),
    );
  }
}
