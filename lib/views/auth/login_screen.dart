// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/global/fonts/app_fonts.dart';
import 'package:hobbyzhub/global/pixels/app_pixels.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/auth/forget_password.dart';
import 'package:hobbyzhub/views/auth/registration_screen.dart';
import 'package:hobbyzhub/views/bottom_nav_bar/main_tabs_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/password_field_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import 'complete_profile_screen1.dart';

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

  // other variables
  String? isRegistering;

  @override
  void initState() {
    UserSecureStorage.fetchIsRegistering().then((value) {
      isRegistering = value;
    });
    super.initState();
  }

  initLocalStorage(var data) async {
    Future.wait([
      UserSecureStorage.setToken(data?.accessToken),
      UserSecureStorage.setUserId(data?.userId),
      UserSecureStorage.setExpiryTime(data?.tokenExpiresAt),
    ]);
  }

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
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthLoadingState) {
              // unfocus keyboard
              FocusScope.of(context).unfocus();
              // show loading
              AppDialogs.loadingDialog(context);
            } else if (state is AuthLoginState) {
              AppDialogs.closeDialog(context);
              await initLocalStorage(state.response.data);
              if (isRegistering == "true") {
                AppNavigator.goToPageWithReplacement(
                  context: context,
                  screen: const CompleteProfileScreen1(),
                );
              } else {
                AppNavigator.goToPageWithReplacement(
                  context: context,
                  screen: const MainTabScreen(index: 0),
                );
              }
            } else if (state is AuthStateFailure) {
              AppDialogs.closeDialog(context);
              toast(state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
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
                            validator: AppValidators.password,
                          ),
                          20.height,
                          // Forgot password
                          TextButton(
                            onPressed: () {
                              AppNavigator.goToPage(
                                context: context,
                                screen: const ForgetPasswordScreen(),
                              );
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.poppins,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                                fontSize: AppPixels.subHeading,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.height() * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PrimaryButtonWidget(
                                    caption: "Login",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                              AuthEventLogin(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim(),
                                              ),
                                            );
                                      }
                                    }),
                              ],
                            ),
                          ),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  AppNavigator.goToPageWithReplacement(
                                    context: context,
                                    screen: const RegistrationScreen(),
                                  );
                                },
                                child: Text(
                                  "Register",
                                  style: AppTextStyle.button,
                                ),
                              ),
                            ],
                          ),
                          30.height,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
