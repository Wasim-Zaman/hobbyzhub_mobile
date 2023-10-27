import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class TwoButtonsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? color;
  const TwoButtonsAppbar({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      title: Text(title.toString(), style: AppTextStyle.headings),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed ?? () {},
        ),
      ],
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
