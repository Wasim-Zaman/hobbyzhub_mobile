import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/themes/app_theme.dart';
import 'package:hobbyzhub/views/auth/registration_screen.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HobbyzHub',
      theme: AppTheme.light,
      navigatorKey: navigatorKey,
      home: const RegistrationScreen(),
    );
  }
}
