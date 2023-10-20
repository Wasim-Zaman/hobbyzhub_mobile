import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/global/fonts/app_fonts.dart';
import 'package:hobbyzhub/global/pixels/app_pixels.dart';

class AppTextStyle {
  static var headings = TextStyle(
    fontSize: AppPixels.heading,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: AppFonts.jost,
  );
}
