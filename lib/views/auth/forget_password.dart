import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/auth/otp_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const BackAppbarWidget(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  Text('Forgot password', style: AppTextStyle.headings),
                  30.height,
                  Text('Please enter your email below to receive your OTP ',
                      style: AppTextStyle.subHeading),
                  50.height,
                  TextFieldWidget(
                    controller: emailController,
                    labelText: "EMAIL",
                    hintText: "Enter your email",
                    validator: AppValidators.email,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: PrimaryButtonWidget(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // remove focus from the text field
                      FocusScope.of(context).unfocus();
                      AppNavigator.goToPage(
                          context: context,
                          screen: OtpScreen(
                            email: emailController.text.trim(),
                          ));
                    }
                  },
                  caption: 'Send OTP',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
