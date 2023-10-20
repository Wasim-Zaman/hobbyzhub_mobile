import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/global/fonts/app_fonts.dart';
import 'package:hobbyzhub/global/pixels/app_pixels.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
    Key? key,
    required this.caption,
    required this.onPressed,
    this.width,
    this.height,
    this.margin,
  }) : super(key: key);

  final String caption;
  final VoidCallback onPressed;
  final double? width, height;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        child: Text(
          caption,
          style: TextStyle(
            color: AppColors.black,
            fontSize: AppPixels.button,
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
