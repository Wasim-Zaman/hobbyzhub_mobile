import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/update_profile/update_profile_cubit.dart';
import 'package:hobbyzhub/blocs/user_profile/profile_cubit.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/user/user_profile_model.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/auth/complete_profile_screen2.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/network_image_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/dob_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfileModel editProfile;

  const EditProfileScreen({super.key, required this.editProfile});

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
  File? _imgFile;
  late ProfileCubit profileCubit;

  @override
  void initState() {
    print(widget.editProfile.toJson());
    nameController.text = widget.editProfile.data.fullName;
    emailController.text = widget.editProfile.data.email;
    bioController.text = widget.editProfile.data.bio;
    dobController.text = widget.editProfile.data.birthdate;

    super.initState();
  }

  updateData() async {
    final userId = await UserSecureStorage.fetchUserId();

    profileCubit = context.read<ProfileCubit>();
    profileCubit.getProfileInfo(userId);
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
          Navigator.of(context).pop();
          updateData();

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
                    !widget.editProfile.data.profileImage.isEmptyOrNull &&
                            _imgFile == null
                        ? NetworkImageWidget(
                            imageUrl:
                                widget.editProfile.data.profileImage ?? '',
                            isEditable: true,
                            onEditClicked: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? img = await picker.pickImage(
                                source: ImageSource
                                    .camera, // alternatively, use ImageSource.gallery
                                maxWidth: 400,
                              );
                              if (img == null) return;
                              setState(() {
                                _imgFile = File(
                                    img.path); // convert it to a Dart:io file
                              });
                            },
                          )
                        : widget.editProfile.data.profileImage.isEmptyOrNull &&
                                _imgFile == null
                            ? const ImagePickWidget()
                            : Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 120.h,
                                      width: 120.w,
                                      padding: const EdgeInsets.all(5),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 4,
                                          color: AppColors.borderGrey,
                                        ),
                                        image: DecorationImage(
                                          // will change it later from asset image to cached network image
                                          image: FileImage(_imgFile!),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -5,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? img =
                                              await picker.pickImage(
                                            source: ImageSource
                                                .camera, // alternatively, use ImageSource.gallery
                                            maxWidth: 400,
                                          );
                                          if (img == null) return;
                                          setState(() {
                                            _imgFile = File(img
                                                .path); // convert it to a Dart:io file
                                          });
                                        },
                                        icon: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.white),
                                          child: const CircleAvatar(
                                            radius: 15,
                                            backgroundColor: AppColors.grey,
                                            child: Icon(Icons.edit_outlined,
                                                size: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                            _imgFile,
                            nameController.text.trim(),
                            bioController.text.trim(),
                            dobController.text.trim(),
                            widget.editProfile.data.gender);
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
