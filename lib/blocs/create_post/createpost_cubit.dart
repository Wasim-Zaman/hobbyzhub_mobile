import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/create_post/create_post.dart';
import 'package:meta/meta.dart';

part 'createpost_state.dart';

class CreatepostCubit extends Cubit<CreatepostState> {
  CreatepostCubit() : super(CreatepostInitial());

  PostController postController = PostController();

  createPost(List<File> imageFile, caption, hastags) async {
    emit(CreatepostLoading());
    try {
      var response =
          await postController.createPost(imageFile, caption, hastags);

      if (response.statusCode == 201) {
        emit(CreatepostSuccessfully());
      } else {
        emit(CreatepostFailed());
      }
    } on SocketException {
      emit(CreatepostInternetError());
    } catch (e) {
      print(e);
      emit(CreatepostFailed());
    }
  }
}
