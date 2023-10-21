// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/welcome/welcome_screen.dart';

class DineScreen extends StatefulWidget {
  const DineScreen({super.key});

  @override
  State<DineScreen> createState() => _DineScreenState();
}

class _DineScreenState extends State<DineScreen> {
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
              child: Image.asset(ImageAssets.dineImage),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dive into Hobbyzhub's World",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.headings),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Dive in and explore a world of endless hobbies, connect with enthusiasts, and unleash your creativity.",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.subHeading),
                    ],
                  ),
                )),
            Padding(
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (builder) => WelcomeScreen()));
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 84,
                          child: Text('Dive In ',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.whiteButtonTextStyle),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
