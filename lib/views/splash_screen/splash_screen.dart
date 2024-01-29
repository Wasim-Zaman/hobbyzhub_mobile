// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/bottom_nav_bar/main_tabs_screen.dart';
import 'package:hobbyzhub/views/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      sessionHandling();
    });
    super.initState();
  }

  sessionHandling() async {
    final token = await UserSecureStorage.fetchToken();
    final userId = await UserSecureStorage.fetchUserId();

    if (token == null || userId == null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (builder) => const OnboardingScreen(),
        ),
      );
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (builder) => const MainTabScreen(
                index: 0,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          ImageAssets.welcomeImage,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
