import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.height,
            Text('Register on Hobbyzhub', style: AppTextStyle.headings),
            20.height,
            Text('Lets create you an account', style: AppTextStyle.subHeading),
            20.height,
            TextFieldWidget(
              labelText: 'Email',
              controller: emailController,
              hintText: "Enter your email",
              validator: AppValidators.email,
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText, hintText;
  final String? Function(String?)? validator;
  const PasswordFieldWidget(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.hintText,
      this.validator})
      : super(key: key);

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: AppTextStyle.textField,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderGrey),
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
