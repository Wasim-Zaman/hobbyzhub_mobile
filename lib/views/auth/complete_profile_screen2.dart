import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/dropdowns/dropdown_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class CompleteProfileScreen2 extends StatefulWidget {
  const CompleteProfileScreen2({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen2> createState() => _CompleteProfileScreen2State();
}

class _CompleteProfileScreen2State extends State<CompleteProfileScreen2> {
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
                          const PickImageWidget(),
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

class DobWidget extends StatelessWidget {
  const DobWidget({
    super.key,
    required this.dobController,
  });

  final TextEditingController dobController;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      labelText: "DATE OF BIRTH",
      controller: dobController,
      hintText: 'Select your birth date',
      readOnly: true,
      prefixIcon: IconButton(
        icon: const Icon(
          Ionicons.calendar_outline,
          color: AppColors.darkGrey,
        ),
        onPressed: () {
          // show date picker
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((value) {
            if (value != null) {
              // set date to controller
              dobController.text = value.toString().split(' ')[0];
            }
          });
        },
      ),
    );
  }
}

class PickImageWidget extends StatelessWidget {
  const PickImageWidget({
    super.key,
  });

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
            child: const Center(
              child: Icon(
                LineIcons.user,
                size: 80,
                color: AppColors.darkGrey,
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
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
