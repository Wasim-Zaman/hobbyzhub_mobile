import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/dropdowns/dropdown_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/dob_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/password_field_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final dobController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final changePasswordController = TextEditingController();
  final rePasswordController = TextEditingController();

  // Focus Nodes
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final bioFocusNode = FocusNode();
  final dobFocusNode = FocusNode();

  // Other variables
  final List<String> gender = ['Male', 'Femal'];
  String? selectedGender;

  String? dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "Edit Profile"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFieldWidget(
                    labelText: "Name",
                    controller: nameController,
                    hintText: "Enter your name",
                  ),
                  20.height,
                  TextFieldWidget(
                    labelText: "Email",
                    controller: emailController,
                    hintText: "Enter your email",
                  ),
                  20.height,
                  TextFieldWidget(
                    labelText: "Bio",
                    controller: bioController,
                    hintText: "Enter your bio",
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                  ),
                  20.height,
                  DropdownWidget(
                    items: gender,
                    value: selectedGender,
                    hint: "Select a gender",
                    onChanged: (value) {
                      selectedGender = value;
                    },
                  ),
                  20.height,
                  DobWidget(
                    dobController: dobController,
                    onChanged: (p0) {},
                  ),
                  30.height,
                  Text("Change Password", style: AppTextStyle.headings),
                  20.height,
                  PasswordFieldWidget(
                    labelText: "Current Password",
                    controller: currentPasswordController,
                    hintText: "Enter current password",
                  ),
                  20.height,
                  PasswordFieldWidget(
                    labelText: "Change Password",
                    controller: changePasswordController,
                    hintText: "Enter new password",
                  ),
                  20.height,
                  PasswordFieldWidget(
                    labelText: "RE-PASSWORD",
                    controller: currentPasswordController,
                    hintText: "Enter current password",
                  ),
                  30.height,
                  PrimaryButtonWidget(
                    caption: "Update",
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
