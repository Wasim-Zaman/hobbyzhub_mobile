import 'package:flutter/material.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogueContext = ctx;
        return const CircularProgressIndicator();
      },
    );
  }

  static void closeDialog() {
    Navigator.pop(dialogueContext!);
  }
}
