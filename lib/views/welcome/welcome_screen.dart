// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/auth/login_screen.dart';
import 'package:hobbyzhub/views/auth/registration_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/outlined_button.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              flex: 3,
              child: Image.asset(ImageAssets.loginImage),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome to HobbyzHub",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.headings),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "A place where hobbyist meet, expound and support eachother.",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.subHeading),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: PrimaryButtonWidget(
                  width: MediaQuery.of(context).size.width,
                  caption: 'Registration',
                  onPressed: () {
                    AppNavigator.goToPageWithReplacement(
                      context: context,
                      screen: RegistrationScreen(),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
              child: OutlinedButtonWidget(
                  width: MediaQuery.of(context).size.width,
                  caption: 'Login',
                  onPressed: () {
                    AppNavigator.goToPageWithReplacement(
                      context: context,
                      screen: LoginScreen(),
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
