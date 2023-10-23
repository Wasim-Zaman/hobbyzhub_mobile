import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/password_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const BackAppbarWidget(),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Text('Recovery Password', style: AppTextStyle.headings),
                30.height,
                Text(
                    'Enter your new and confirm password to reset your password.',
                    style: AppTextStyle.subHeading),
                50.height,
                PasswordFieldWidget(
                  controller: passwordController,
                  labelText: "Password",
                  hintText: "Password",
                ),
                30.height,
                PasswordFieldWidget(
                  controller: confirmPasswordController,
                  labelText: "Re-Password",
                  hintText: "Re-Password",
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.w),
              child: PrimaryButtonWidget(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (builder) =>  OtpScreen()));
                },
                caption: 'Reset Password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
