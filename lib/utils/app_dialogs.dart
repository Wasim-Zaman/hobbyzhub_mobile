import 'package:flutter/material.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogueContext = ctx;
        return const LoadingWidget();
      },
    );
  }

  static void closeDialog() {
    Navigator.pop(dialogueContext!);
  }
}
