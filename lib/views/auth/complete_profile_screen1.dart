// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/models/auth/complete_profile_model.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/auth/complete_profile_screen2.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class CompleteProfileScreen1 extends StatefulWidget {
  const CompleteProfileScreen1({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen1> createState() => _CompleteProfileScreen1State();
}

class _CompleteProfileScreen1State extends State<CompleteProfileScreen1> {
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  // Focus node
  FocusNode nameFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();

  // form key
  final formKey = GlobalKey<FormState>();

  late CompleteProfileModel model;

  @override
  void initState() {
    super.initState();
  }

  onClick() {
    model = CompleteProfileModel(
      name: nameController.text,
      bio: bioController.text,
    );

    AppNavigator.goToPage(
      context: context,
      screen: CompleteProfileScreen2(
        model: model,
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.height,
                    Text('Let’s personalize your experience',
                        style: AppTextStyle.headings),
                    20.height,
                    Text(
                      'What can we call you? Could be your name, a nickname or something funny',
                      style: AppTextStyle.subHeading,
                    ),
                    20.height,
                    TextFieldWidget(
                      labelText: 'NAME',
                      controller: nameController,
                      hintText: "Enter your name",
                      validator: AppValidators.notEmpty,
                      focusNode: nameFocusNode,
                    ),
                    20.height,
                    TextFieldWidget(
                      labelText: 'BIO',
                      controller: bioController,
                      hintText: "Enter your bio",
                      validator: AppValidators.notEmpty,
                      focusNode: bioFocusNode,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    20.height,
                    SizedBox(
                      height: context.height() * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PrimaryButtonWidget(
                              caption: "Next",
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await onClick();
                                }
                              }),
                        ],
                      ),
                    ),
                    30.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
