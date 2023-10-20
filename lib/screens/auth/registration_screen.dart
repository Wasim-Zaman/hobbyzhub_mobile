import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text('Register on HobbyzHub', style: AppTextStyle.headings),
          ],
        ),
      ),
    );
  }
}
