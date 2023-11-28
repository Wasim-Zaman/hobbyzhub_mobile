// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/hash_tags/hash_tags_bloc.dart';
import 'package:hobbyzhub/blocs/image_picker/multi_image_picker_bloc.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
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
    return Scaffold(
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
                TextFieldWidget(
                  labelText: "Hash Tags",
                  controller: hashTagsController,
                  hintText: "Add Hash Tags",
                  focusNode: hashTagsFocusNode,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
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
                BlocBuilder<HashTagsBloc, HashTagsState>(
                  bloc: hashTagsBloc,
                  builder: (context, state) {
                    if (state is HashTagsStateSuccess) {
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
                const Spacer(),
                // post the media files (images and videos)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PrimaryButtonWidget(
                        caption: "Cancel",
                        onPressed: () {
                          captionController.clear();
                          hashTagsController.clear();
                          pickedFiles.clear();
                          clear();
                        },
                        color: AppColors.darkGrey,
                        circularRadius: 5,
                        height: 45,
                      ),
                    ),
                    20.width,
                    Expanded(
                      child: PrimaryButtonWidget(
                        caption: "Post",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {}
                        },
                        circularRadius: 5,
                        height: 45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
