// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/create_post/createpost_cubit.dart';
import 'package:hobbyzhub/blocs/get_post/get_post_cubit.dart';
import 'package:hobbyzhub/blocs/hash_tags/hash_tags_bloc.dart';
import 'package:hobbyzhub/blocs/image_picker/multi_image_picker_bloc.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/views/widgets/appbars/secondary_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // Blocs
  late MultiImagePickerBloc multiImagePickerBloc;
  late HashTagsBloc hashTagsBloc;

  // controller for the text field
  TextEditingController captionController = TextEditingController();
  TextEditingController hashTagsController = TextEditingController();

  // focus node for the text field
  FocusNode captionFocusNode = FocusNode();
  FocusNode hashTagsFocusNode = FocusNode();

  // form key
  final formKey = GlobalKey<FormState>();

  // list of media files (images and videos)
  List<XFile> pickedFiles = [];
  // list of hash tags
  List<String> hashTags = [];
  List<String> hastagsData = [];

  @override
  void initState() {
    super.initState();
    // initialize the bloc
    multiImagePickerBloc = MultiImagePickerBloc();
    hashTagsBloc = HashTagsBloc();
  }

  void pickFiles() {
    // pick media files (images and videos)
    multiImagePickerBloc.add(MultiImagePickerEventPickFiles(ImagePicker()));
  }

  void clear() {
    // clear the selected media files (images and videos)
    multiImagePickerBloc.add(MultiImagePickerEventClear());
  }

  @override
  void dispose() {
    super.dispose();
    // dispose the bloc
    multiImagePickerBloc.close();

    // dispose the controllers
    captionController.dispose();
    hashTagsController.dispose();

    // dispose the focus nodes
    captionFocusNode.dispose();
    hashTagsFocusNode.dispose();

    // clear the list of media files (images and videos)
    pickedFiles.clear();

    // clear the list of hash tags
    hashTags.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatepostCubit, CreatepostState>(
      listener: (context, state) {
        if (state is CreatepostLoading) {
          AppDialogs.loadingDialog(context);
        } else if (state is CreatepostSuccessfully) {
          context.read<GetPostCubit>().getPostList();

          captionController.clear();
          hastagsData.clear();
          pickedFiles.clear();
          setState(() {});
          toast("Your post created successfully");

          AppDialogs.closeDialog(context);
        } else if (state is CreatepostFailed) {
          toast("Your post creation failed");

          AppDialogs.closeDialog(context);
        } else if (state is CreatepostInternetError) {
          toast("Internet connection failed");

          AppDialogs.closeDialog(context);
        }
      },
      child: Scaffold(
        appBar: SecondaryAppBarWidget(
          title: "Create New Post",
          isBackButton: false,
        ),
        // create a screen having camera already opened in the screen view
        body: MultiBlocListener(
          listeners: [
            BlocListener<MultiImagePickerBloc, MultiImagePickerState>(
              bloc: multiImagePickerBloc,
              listener: (context, state) {
                if (state is MultiImagePickerStatePickedFiles) {
                  setState(() {
                    pickedFiles = state.pickedFiles;
                  });
                } else if (state is MultiImagePickerStateClear) {
                  pickedFiles.clear();
                }
              },
            ),
            BlocListener<HashTagsBloc, HashTagsState>(
              bloc: hashTagsBloc,
              listener: (context, state) {
                if (state is HashTagsStateSuccess) {
                  // add the hash tag to the list of hash tags
                  hashTags = state.tags;
                }
              },
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // pick media files (images and videos)
                  GestureDetector(
                    onTap: () {
                      pickFiles();
                    },
                    child: Image.asset(
                      "assets/images/cameraImage.jpeg",
                      height: 100.h,
                      width: 100.w,
                    ),
                  ).visible(pickedFiles.isEmpty),

                  // display the selected media files (images and videos)
                  SizedBox(
                    height: 100,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: pickedFiles.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        // display the media files (image or video)
                        return Image.file(
                          File(pickedFiles[index].path),
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ).visible(pickedFiles.isNotEmpty),
                  30.height,
                  TextFieldWidget(
                    labelText: "Caption",
                    controller: captionController,
                    hintText: "Add Caption",
                    focusNode: captionFocusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                  ),
                  20.height,
                  TextField(
                    controller: hashTagsController,
                    focusNode: hashTagsFocusNode,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: "HASHTAGS",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.lightGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.primary),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: AppColors.dangerColor),
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                    ),
                    onEditingComplete: () {
                      hashTags.add(hashTagsController.text);
                      // add the hash tag to the list of hash tags
                      hashTagsBloc.add(HashTagsEventHandler(hashTags));
                      // clear the hash tag text field
                      hashTagsController.clear();
                    },
                  ),
                  20.height,
                  // display the list of hash tags
                  Expanded(
                    child: BlocBuilder<HashTagsBloc, HashTagsState>(
                      bloc: hashTagsBloc,
                      builder: (context, state) {
                        if (state is HashTagsStateSuccess) {
                          hastagsData = state.tags;
                          return Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: hashTags
                                .map(
                                  (hashTag) => Chip(
                                    label: Text(hashTag),
                                    onDeleted: () {
                                      // remove the hash tag from the list of hash tags
                                      hashTags.remove(hashTag);
                                      hashTagsBloc
                                          .add(HashTagsEventHandler(hashTags));
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const Spacer(),

                  20.width,
                  PrimaryButtonWidget(
                    caption: "Post",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        List<File> imagePickedFiles = [];
                        for (var i = 0; i < pickedFiles.length; i++) {
                          imagePickedFiles.add(File(pickedFiles[i].path));
                        }

                        context.read<CreatepostCubit>().createPost(
                              imagePickedFiles,
                              captionController.text.trim(),
                              hastagsData,
                            );
                      }
                    },
                    circularRadius: 5,
                    height: 45,
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
