// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/session/session_bloc.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/auth/complete_profile_screen1.dart';
import 'package:hobbyzhub/views/bottom_nav_bar/main_tabs_screen.dart';
import 'package:hobbyzhub/views/onboarding/onboarding_screen.dart';
import 'package:hobbyzhub/views/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SessionBloc bloc = SessionBloc();
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      // sessionHandling();
      bloc.add(SessionRefreshToken());
    });
    super.initState();
  }

  sessionHandling(SessionState state) async {
    final token = await UserSecureStorage.fetchToken();
    final userId = await UserSecureStorage.fetchUserId();

    if (state is SessionSuccess) {
      if (state.response['isVerified']) {
        if (state.response['newUser']) {
          AppNavigator.goToPage(
            context: context,
            screen: const CompleteProfileScreen1(),
          );
        } else if (state.response['newUser'] == false &&
            state.response['categoryStatus'] == false) {
          AppNavigator.goToPage(
            context: context,
            screen: const CompleteProfileScreen1(),
          );
        } else if (state.response['newUser'] == false &&
            state.response['categoryStatus'] == true) {
          AppNavigator.goToPageWithReplacement(
            context: context,
            screen: const MainTabScreen(index: 0),
          );
        }
      } else if (state is SessionFailure) {
        AppNavigator.goToPageWithReplacement(
          context: context,
          screen: const OnboardingScreen(),
        );
      }
    } else {
      AppNavigator.goToPageWithReplacement(
        context: context,
        screen: const WelcomeScreen(),
      );
    }

    // if (token == null || userId == null) {
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (builder) => const OnboardingScreen(),
    //     ),
    //   );
    // } else {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (builder) => const MainTabScreen(
    //             index: 0,
    //           )));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SessionBloc, SessionState>(
      bloc: bloc,
      listener: (context, state) {
        sessionHandling(state);
      },
      child: Stack(
        children: [
          Image.asset(
            ImageAssets.welcomeImage,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
