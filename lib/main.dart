import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/themes/app_theme.dart';
import 'package:hobbyzhub/views/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HobbyzHub',
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
