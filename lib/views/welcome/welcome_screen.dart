// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
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
                      Text(
                        "Welcome to HobbyzHub",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF181818),
                          fontSize: 28,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A place where hobbyist meet, expound and support eachother.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF979797),
                          fontSize: 18,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: PrimaryButtonWidget(
                  width: MediaQuery.of(context).size.width,
                  caption: 'Registration',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (builder) => RegistrationScreen()),
                        (route) => false);
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
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (builder) => RegistrationScreen()),
                        (route) => false);
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
