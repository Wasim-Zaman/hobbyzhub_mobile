import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';

class ChatField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onPressed;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;

  const ChatField({
    Key? key,
    this.controller,
    this.onPressed,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x21000000),
            blurRadius: 30,
            offset: Offset(5, 4),
            spreadRadius: 0,
          )
        ],
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          // maxLength: 1000,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText ?? 'Write your message',
            fillColor: Colors.white,
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          style: AppTextStyle.subcategoryUnSelectedTextStyle,
        ),
      ),
    );
  }
}
