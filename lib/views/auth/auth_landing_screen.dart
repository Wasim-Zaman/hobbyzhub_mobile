import 'package:flutter/material.dart';
import 'package:hobbyzhub/views/auth/login_screen.dart';
import 'package:hobbyzhub/views/auth/registration_screen.dart';

class AuthLandingScreen extends StatefulWidget {
  const AuthLandingScreen({super.key});

  @override
  State<AuthLandingScreen> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends State<AuthLandingScreen> {
  bool _isLogin = false;

  void toggleAuth() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLogin) {
      return LoginScreen(toggleAuth: toggleAuth);
    } else {
      return RegistrationScreen(toggleAuth: toggleAuth);
    }
  }
}
