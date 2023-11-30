import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/create_post/create_post.dart';
import 'package:meta/meta.dart';

part 'createpost_state.dart';

class CreatepostCubit extends Cubit<CreatepostState> {
  CreatepostCubit() : super(CreatepostInitial());

  PostController postController = PostController();

  createPost(List<File> imageFile) async {
    try {
      print(imageFile);
      await postController.createPost(imageFile);
    } catch (e) {
      print(e);
    }
  }
}
