import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class BackAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const BackAppbarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: Container(
          decoration: ShapeDecoration(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1.5, color: AppColors.borderGrey),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
