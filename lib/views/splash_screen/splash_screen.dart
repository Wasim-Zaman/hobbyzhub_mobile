// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/auth/complete_profile_screen1.dart';
import 'package:hobbyzhub/views/bottom_nav_bar/main_tabs_screen.dart';
import 'package:hobbyzhub/views/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc bloc = AuthBloc();
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      bloc.add(AuthRefreshTokenEvent());
    });
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthRefreshTokenSuccess) {
          if (state.response['verified'] == true) {
            if (state.response['newUser']) {
              AppNavigator.goToPageWithReplacement(
                context: context,
                screen: const CompleteProfileScreen1(),
              );
            } else if (state.response['newUser'] == false &&
                state.response['categoryStatus'] == false) {
              AppNavigator.goToPageWithReplacement(
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
          } else {
            AppNavigator.goToPageWithReplacement(
              context: context,
              screen: const WelcomeScreen(),
            );
          }
        } else if (state is AuthRefreshTokenError) {
          AppNavigator.goToPageWithReplacement(
            context: context,
            screen: const WelcomeScreen(),
          );
        }
      },
      builder: (context, state) {
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
      },
    );
  }
}
