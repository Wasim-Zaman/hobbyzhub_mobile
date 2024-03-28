// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/group/add_group_members.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupName = TextEditingController();
  final TextEditingController description = TextEditingController();

  // Media
  File? media;

  // Other
  final groupNameFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  pickMedia() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        media = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    groupName.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppbarWidget(),
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(12.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      'Lets Bring Your Passion to Life. Start Your Own Hobby Community.',
                      style: TextStyle(
                        color: Color(0xFF181818),
                        fontSize: 24,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  30.height,
                  SizedBox(
                    width: 100.w,
                    height: 130.h,
                    child: Stack(
                      children: [
                        Container(
                          width: 100.w,
                          height: 93.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFFA0A2B3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28.r),
                            child: media != null
                                ? Image.file(
                                    media!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    ImageAssets.createGroupImage,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                        Positioned(
                          left: 28.w,
                          top: 75.h,
                          child: GestureDetector(
                            onTap: () {
                              // pick image
                              pickMedia();
                            },
                            child: Container(
                              width: 40.w,
                              height: 36.h,
                              decoration: ShapeDecoration(
                                color: Color(0xFF394851),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFieldWidget(
                      labelText: "Group Name",
                      controller: groupName,
                      hintText: "Enter your group name"),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFieldWidget(
                      maxLines: 6,
                      labelText: "Description",
                      controller: description,
                      hintText: "Enter group description...."),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PrimaryButtonWidget(
            caption: "Next",
            onPressed: () {
              AppNavigator.goToPage(
                  context: context,
                  screen: AddGroupMembers(
                    groupName: groupName.text,
                    groupDescription: description.text,
                    groupImage: media,
                  ));
            }),
      ),
    );
  }
}
