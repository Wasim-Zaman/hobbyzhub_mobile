import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_validators.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText, hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final Function(String)? onChanged;

  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.onEditingComplete,
    this.textInputAction,
    this.maxLines,
    this.readOnly,
    this.prefixIcon,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator ?? AppValidators.notEmpty,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines ?? 1,
      textInputAction: widget.textInputAction ??
          (widget.focusNode == null
              ? TextInputAction.done
              : TextInputAction.next),
      onEditingComplete: widget.onEditingComplete ??
          () {
            if (widget.focusNode != null) {
              // change focus to next field
              widget.focusNode!.nextFocus();
            } else {
              // Unfocus the current field
              FocusScope.of(context).unfocus();
            }
          },
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly ?? false,
      decoration: InputDecoration(
        labelText: widget.labelText.toUpperCase(),
        hintText: widget.hintText,
        hintStyle: AppTextStyle.textField,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: AppTextStyle.textField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.dangerColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.dangerColor),
        ),
        errorStyle: AppTextStyle.textField.copyWith(
          color: AppColors.dangerColor,
        ),
        fillColor: AppColors.white,
        filled: true,
      ),
    );
  }
}
