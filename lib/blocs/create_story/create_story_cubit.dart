import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/create_post/create_post.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:meta/meta.dart';

part 'create_story_state.dart';

class CreateStoryCubit extends Cubit<CreateStoryState> {
  CreateStoryCubit() : super(CreateStoryInitial());

  PostController storyController = PostController();

  createstory(File imageFile, caption, duration) async {
    emit(CreatestoryLoading());
    try {
      final email = await UserSecureStorage.fetchUserEmail();
      print(email);
      var response = await storyController.createStory(
          imageFile, caption, email, duration);

      if (response.statusCode == 200) {
        emit(CreatestorySuccessfully());
      } else {
        emit(CreatestoryFailed());
      }
    } on SocketException {
      emit(CreatestoryInternetError());
    } catch (e) {
      emit(CreatestoryFailed());
    }
  }
}
