import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/global/fonts/app_fonts.dart';
import 'package:hobbyzhub/global/pixels/app_pixels.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/auth/forget_password.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/password_field_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Focus Nodes
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.height,
                Text('Welcome Back', style: AppTextStyle.headings),
                20.height,
                Text(
                  'Lets get back to connect you to LetsCom, shall we',
                  style: AppTextStyle.subHeading,
                ),
                20.height,
                TextFieldWidget(
                  labelText: 'EMAIL',
                  controller: emailController,
                  hintText: "Enter your email",
                  validator: AppValidators.email,
                ),
                20.height,
                PasswordFieldWidget(
                  labelText: 'PASSWORD',
                  controller: passwordController,
                  hintText: "Enter your password",
                ),
                20.height,
                // Forgot password
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => const ForgetPasswordScreen()));
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.poppins,
                      decoration: TextDecoration.underline,
                      fontSize: AppPixels.subHeading,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButtonWidget(
                          caption: "Login",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('validated');
                            } else {
                              print('not validated');
                            }
                          }),
                    ],
                  ),
                ),
                20.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New here?'),
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text("Register", style: AppTextStyle.button),
                    ),
                  ],
                ),
                30.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
