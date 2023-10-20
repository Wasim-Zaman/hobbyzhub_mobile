import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/password_field_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  // focus nodes
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    rePasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              Text('Register on Hobbyzhub', style: AppTextStyle.headings),
              20.height,
              Text('Lets create you an account',
                  style: AppTextStyle.subHeading),
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
              PasswordFieldWidget(
                labelText: 'RE-PASSWORD',
                controller: rePasswordController,
                hintText: "Re-enter your password",
              ),
              20.height,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PrimaryButtonWidget(
                        caption: "Register",
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
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              30.height,
            ],
          ),
        ),
      ),
    );
  }
}
