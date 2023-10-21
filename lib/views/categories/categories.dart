// ignore_for_file: library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/categories/sub_categories.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:nb_utils/nb_utils.dart';

class MainCategoryScreen extends StatefulWidget {
  const MainCategoryScreen({Key? key}) : super(key: key);

  @override
  _MainCategoryScreenState createState() => _MainCategoryScreenState();
}

class _MainCategoryScreenState extends State<MainCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0x33A0A2B3)),
                borderRadius: BorderRadius.circular(10.r),
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
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            Text('Hobby Categories', style: AppTextStyle.headings),
            15.height,
            Text(
                'Select your hobby category to find and connect with people of similar interest',
                style: AppTextStyle.subHeading),
            20.height,
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(5.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (builder) => SubCategoryScreen()));
                      },
                      child: Container(
                        width: 80.w,
                        height: 97.h,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 7,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://vectips.com/wp-content/uploads/2017/03/project-preview-large-2.png",
                              height: 40.h,
                            ),
                            Text('Camera'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryButtonWidget(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  onPressed: () {},
                  caption: 'Next',
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
        ).paddingAll(9.w),
      ),
    );
  }
}
