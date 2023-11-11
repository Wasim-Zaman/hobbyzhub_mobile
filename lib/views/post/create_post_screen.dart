import 'package:flutter/material.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbarWidget(title: "Create New Post"),
      // create a screen having camera already opened in the screen view
      body: const Center(
        child: Text("Create Post"),
      ),
    );
  }
}
