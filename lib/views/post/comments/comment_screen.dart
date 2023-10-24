import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
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
        centerTitle: true,
        title: Text(
          'Comments',
          style: AppTextStyle.headings,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Icon(
              Icons.delete_outline,
              size: 30.sp,
            ),
          ),
        ],
      ),
    );
  }
}
