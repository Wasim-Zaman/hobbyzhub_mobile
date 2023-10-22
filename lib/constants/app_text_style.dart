// ignore_for_file: prefer_const_constructors

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

  static var subHeading = TextStyle(
    fontSize: AppPixels.subHeading,
    color: AppColors.darkGrey,
    fontFamily: AppFonts.jost,
  );

  static var textField = TextStyle(
    fontSize: AppPixels.subHeading,
    color: AppColors.black,
    fontFamily: AppFonts.jost,
  );

  static var button = const TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static var resentOtpTextStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primary,
    color: Color(0xFF26A4FF),
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static var codeTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static var whiteButtonTextStyle = const TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: AppPixels.subHeading,
  );

  static var outlinedButtonTextStyle = const TextStyle(
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontSize: AppPixels.subHeading,
  );

  static var subcategoryUnSelectedTextStyle = TextStyle(
    color: Color(0xFF676767),
    fontSize: 12,
    fontFamily: AppFonts.jost,
    fontWeight: FontWeight.w500,
  );

  static var subcategorySelectedTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: AppFonts.jost,
    fontWeight: FontWeight.w500,
  );

  static var pinput = TextStyle(
    fontSize: 22,
    color: AppColors.darkGrey,
  );

  static var normal = TextStyle(
    fontSize: 18.0,
    color: AppColors.darkGrey,
  );

  static var dialogHeader = TextStyle(
    fontSize: 20.8,
    color: AppColors.darkGrey,
    fontWeight: FontWeight.bold,
  );

  static var dialogNormal = TextStyle(
    fontSize: 12.8,
    color: AppColors.darkGrey,
  );
}
