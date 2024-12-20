// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/image_picker/image_picker_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/global/variables/global_variables.dart';
import 'package:hobbyzhub/models/auth/complete_profile_model.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_toast.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/categories/main_categories_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/dropdowns/dropdown_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/dob_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class CompleteProfileScreen2 extends StatefulWidget {
  final CompleteProfileModel model;
  const CompleteProfileScreen2({Key? key, required this.model})
      : super(key: key);

  @override
  State<CompleteProfileScreen2> createState() => _CompleteProfileScreen2State();
}

class _CompleteProfileScreen2State extends State<CompleteProfileScreen2> {
  // blocs
  ImagePickerBloc imageBloc = ImagePickerBloc();
  AuthBloc authBloc = AuthBloc();

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
  String? dob;

  @override
  void initState() {
    getLocalStorageData();
    super.initState();
  }

  void getLocalStorageData() {
    // get token and user id from secure storage
    UserSecureStorage.fetchToken().then((value) {
      widget.model.token = value;
    });
    UserSecureStorage.fetchUserId().then((value) {
      widget.model.userId = value;
    });
  }

  void completeProfile() async {
    // adding user id and token to the user model
    widget.model.birthDate = birthDate;
    widget.model.gender = selectedGender;
    if (image != null) {
      widget.model.profilePicture = image;
    }
    authBloc = authBloc..add(AuthEventCompleteProfile(model: widget.model));
  }

  @override
  void dispose() {
    imageBloc.close();
    dobController.dispose();
    birthDate = null;
    image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ImagePickerBloc, ImagePickerState>(
            listener: (context, state) async {
              if (state is ImagePickerPickedImageState) {
                image = state.image;
              } else if (state is ImagePickerFailureState) {
                AppToast.danger("Failed to pick image");
              }
            },
          ),
          // Auth bloc listener
          BlocListener<AuthBloc, AuthState>(
            bloc: authBloc,
            listener: (context, state) {
              if (state is AuthLoadingState) {
                AppDialogs.loadingDialog(context);
              } else if (state is AuthCompleteProfileState) {
                var model = state.response.data as FinishAccountModel;
                AppDialogs.closeDialog(context);
                AppNavigator.goToPageWithReplacement(
                  context: context,
                  screen: MainCategoriesScreen(model: model),
                );
              } else if (state is AuthStateFailure) {
                AppDialogs.closeDialog(context);
                AppToast.danger(state.message);
              } else {
                AppDialogs.closeDialog(context);
              }
            },
          ),
        ],
        child: SafeArea(
          child: SingleChildScrollView(
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
                        const ImagePickWidget(),
                        30.height,
                        // Drop down for selecting gender
                        DropdownWidget(
                          items: gender,
                          value: selectedGender,
                          hint: "Select Your Gender",
                          onChanged: (value) {
                            selectedGender = value;
                          },
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
                                    if (formKey.currentState!.validate()) {
                                      completeProfile();
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
        ),
      ),
    );
  }
}

class ImagePickWidget extends StatefulWidget {
  const ImagePickWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickWidget> createState() => _ImagePickWidgetState();
}

class _ImagePickWidgetState extends State<ImagePickWidget> {
  pickFromGallery() {
    context.read<ImagePickerBloc>().add(
          ImagePickerPickImageEvent(imageSource: ImageSource.gallery),
        );
  }

  pickFromCamera() {
    context.read<ImagePickerBloc>().add(
          ImagePickerPickImageEvent(imageSource: ImageSource.camera),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            height: 140.h,
            width: 130.w,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(40),
            ),
            child: BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
                if (state is ImagePickerPickedImageState) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(40),
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
          Positioned(
            bottom: -5,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.white),
                shape: BoxShape.circle,
              ),
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
                  pickFromGallery();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
