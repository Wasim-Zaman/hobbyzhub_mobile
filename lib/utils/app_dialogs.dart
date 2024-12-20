import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingWidget(), // You can replace this with your own loading widget
              SizedBox(height: 16),
              Text('Please Wait...'),
            ],
          ),
        );
      },
    );
  }

  static void closeDialog(BuildContext context) {
    context.pop();
  }

  static void logoutDialog(BuildContext context, {VoidCallback? logout}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(
            'Log Out',
            style: AppTextStyle.dialogHeader,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyle.dialogNormal,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                context.pop();
              },
              child: Text(
                'Cancel',
                style: AppTextStyle.dialogNormal,
              ),
            ),
            TextButton(
              onPressed: logout ??
                  () {
                    context.pop();
                  },
              child: Text(
                'Ok',
                style: AppTextStyle.dialogNormal,
              ),
            ),
          ],
        );
      },
    );
  }

  // Otp success dialog
  static Future<dynamic> otpSuccessDialog(
    BuildContext context, {
    VoidCallback? onPressed,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColors.primary),
                ),
                child: const CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(
                      Icons.check,
                      color: AppColors.white,
                    )),
              ),
              const SizedBox(height: 20),
              Text(
                "OTP Verification Successful",
                style: AppTextStyle.dialogHeader,
              ),
              const SizedBox(height: 20),
              Text(
                "Your account has been successfully verified. You can now proceed to finishing registration",
                style: AppTextStyle.dialogNormal,
              ),
              const SizedBox(height: 20),
              PrimaryButtonWidget(
                caption: "Continue",
                onPressed: onPressed ??
                    () {
                      context.pop();
                    },
              )
            ],
          ),
        );
      },
    );
  }
}
