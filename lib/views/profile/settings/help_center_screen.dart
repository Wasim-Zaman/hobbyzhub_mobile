import 'package:flutter/material.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final feedBackController = TextEditingController();

  // focus nodes
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final feedBackFocusNode = FocusNode();

  // Form key
  final formKey = GlobalKey<FormState>();

  // Functions
  void submit() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    feedBackController.dispose();

    nameFocusNode.dispose();
    emailFocusNode.dispose();
    feedBackFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "Help Center"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  TextFieldWidget(
                    labelText: "NAME",
                    controller: nameController,
                    focusNode: nameFocusNode,
                    hintText: "Enter your name",
                    validator: AppValidators.notEmpty,
                  ),
                  20.height,
                  TextFieldWidget(
                    labelText: "EMAIL",
                    controller: emailController,
                    hintText: "Enter your email",
                    focusNode: emailFocusNode,
                    validator: AppValidators.email,
                  ),
                  20.height,
                  TextFieldWidget(
                    labelText: "FEEDBACK",
                    controller: feedBackController,
                    hintText: "Go ahead, we are listening",
                    focusNode: feedBackFocusNode,
                    validator: AppValidators.notEmpty,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                  ),
                  20.height,
                  PrimaryButtonWidget(caption: "Submit", onPressed: submit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
