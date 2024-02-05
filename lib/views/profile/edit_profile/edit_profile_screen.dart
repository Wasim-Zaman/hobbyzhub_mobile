import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/image_picker/image_picker_bloc.dart';
import 'package:hobbyzhub/blocs/update_profile/update_profile_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/models/user/user_profile_model.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/views/auth/complete_profile_screen2.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/dropdowns/dropdown_widget.dart';
import 'package:hobbyzhub/views/widgets/images/network_image_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/dob_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/password_field_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfileModel editProfile;

  EditProfileScreen({required this.editProfile});

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

  String? dob;

  @override
  void initState() {
    nameController.text = widget.editProfile.data.fullName;
    emailController.text = widget.editProfile.data.email;
    bioController.text = widget.editProfile.data.bio;
    dobController.text = widget.editProfile.data.birthdate;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileLoading) {
          // unfocus keyboard
          FocusScope.of(context).unfocus();
          // show loading
          AppDialogs.loadingDialog(context);
        } else if (state is UpdateProfileSuccessfully) {
          AppDialogs.closeDialog(context);
          // save token to local storage
          toast('Profile updated successfully');
        } else if (state is UpdateProfileFailed) {
          AppDialogs.closeDialog(context);
          toast('Profile failed to updated');
        }
      },
      child: Scaffold(
        appBar: const BackAppbarWidget(title: "Edit Profile"),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.editProfile.data.profileImage.isNotEmpty
                        ? NetworkImageWidget(
                            imageUrl: widget.editProfile.data.profileImage,
                            isEditable: true,
                          )
                        : const ImagePickWidget(),
                    20.height,
                    TextFieldWidget(
                      labelText: "Name",
                      controller: nameController,
                      hintText: "Enter your name",
                    ),
                    20.height,
                    TextFieldWidget(
                      readOnly: true,
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
                    DobWidget(
                      dobController: dobController,
                      onChanged: (p0) {},
                    ),
                    30.height,
                    PrimaryButtonWidget(
                      caption: "Update",
                      onPressed: () {
                        context.read<UpdateProfileCubit>().updateProfile(
                            context.read<ImagePickerBloc>().image,
                            nameController.text.trim(),
                            bioController.text.trim(),
                            dobController.text.trim());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
