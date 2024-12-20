import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class BasicAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButton;
  final List<Widget>? actions;

  const BasicAppbarWidget({
    Key? key,
    required this.title,
    required this.isBackButton,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(title, style: AppTextStyle.headings),
      centerTitle: isBackButton == true ? true : false,
      automaticallyImplyLeading: isBackButton == true ? true : false,
      leading: isBackButton == false
          ? null
          : Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  decoration: ShapeDecoration(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 1.5, color: AppColors.borderGrey),
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
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
