import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:nb_utils/nb_utils.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    Key? key,
    required this.caption,
    required this.onPressed,
    this.width,
    this.height,
    this.margin,
    this.icon,
    this.color,
    this.circularRadius,
  }) : super(key: key);

  final String caption;
  final VoidCallback onPressed;
  final double? width, height;
  final EdgeInsets? margin;
  final IconData? icon;
  final Color? color;
  final double? circularRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(circularRadius ?? 50),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(caption, style: AppTextStyle.whiteButtonTextStyle),
            20.height.visible(icon != null),
            Icon(icon).visible(icon != null),
          ],
        ),
      ),
    );
  }
}
