import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/image_picker/image_picker_bloc.dart';
import 'package:hobbyzhub/blocs/media/media_upload_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/user/user_model.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/dropdowns/dropdown_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/dop_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class CompleteProfileScreen2 extends StatefulWidget {
  final UserModel user;
  const CompleteProfileScreen2({Key? key, required this.user})
      : super(key: key);

  @override
  State<CompleteProfileScreen2> createState() => _CompleteProfileScreen2State();
}

class _CompleteProfileScreen2State extends State<CompleteProfileScreen2> {
  // blocs
  ImagePickerBloc imageBloc = ImagePickerBloc();
  MediaUploadBloc mediaUploadBloc = MediaUploadBloc();

  // Controllers
  TextEditingController dobController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  // Lists
  final List<String> gender = [
    'male',
    'female',
    'other',
  ];

  String? selectedGender;

  // other variables
  File? image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.height,
                          Text("Set up your profile",
                              style: AppTextStyle.headings),
                          20.height,
                          Text(
                            "Update your profile to connect with your fellow hobbies-ts with better impression.",
                            style: AppTextStyle.subHeading,
                          ),
                          20.height,
                          // Pick image
                          Center(
                            child: Stack(
                              children: [
                                BlocListener<MediaUploadBloc, MediaUploadState>(
                                  bloc: mediaUploadBloc,
                                  listener: (context, state) {
                                    if (state is MediaUploadSuccess) {}
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    height: 140.h,
                                    width: 130.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: BlocConsumer<ImagePickerBloc,
                                        ImagePickerState>(
                                      bloc: imageBloc,
                                      listener: (context, state) async {
                                        if (state
                                            is ImagePickerPickedImageState) {
                                          // upload image
                                          mediaUploadBloc = mediaUploadBloc
                                            ..add(MediaUploadStartedEvent(
                                              userId:
                                                  widget.user.userId.toString(),
                                              file: state.image!,
                                            ));
                                        } else if (state
                                            is ImagePickerFailureState) {}
                                      },
                                      builder: (context, state) {
                                        if (state
                                            is ImagePickerPickedImageState) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            child: Image.file(
                                              state.image!,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        } else {
                                          return const Center(
                                            child: Icon(
                                              LineIcons.user,
                                              size: 80,
                                              color: AppColors.darkGrey,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -5,
                                  right: 0,
                                  left: 0,
                                  child: IconButton(
                                    icon: const CircleAvatar(
                                      backgroundColor: AppColors.iconGrey,
                                      child: Icon(
                                        Ionicons.camera,
                                        size: 20,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    onPressed: () {
                                      imageBloc = imageBloc
                                        ..add(ImagePickerPickImageEvent());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          30.height,
                          // Drop down for selecting gender
                          DropdownWidget(
                            items: gender,
                            value: selectedGender,
                            hint: "Select Your Gender",
                          ),
                          20.height,
                          // Date picker widget
                          DobWidget(dobController: dobController),
                          20.height,
                          SizedBox(
                            height: context.height() * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PrimaryButtonWidget(
                                    caption: "Next",
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {}
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
            );
          },
        ),
      ),
    );
  }
}
