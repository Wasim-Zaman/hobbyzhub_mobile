import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';

class TextValueWidget extends StatelessWidget {
  final String text, value;
  const TextValueWidget({Key? key, required this.text, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyle.normal),
        Text(text, style: AppTextStyle.normal),
      ],
    );
  }
}
