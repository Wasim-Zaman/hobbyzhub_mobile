import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/themes/app_theme.dart';

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
    );
  }
}
