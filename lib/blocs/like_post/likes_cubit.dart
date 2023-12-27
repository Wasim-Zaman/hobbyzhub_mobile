import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/create_post/create_post.dart';
import 'package:meta/meta.dart';

part 'likes_state.dart';

class LikesCubit extends Cubit<LikesState> {
  LikesCubit() : super(LikesInitial());

  PostController postController = PostController();

  createLike(postId) async {
    emit(LikeLoading());
    try {
      var response = await postController.createLikeFunction(postId);
      print(response.body);

      if (response.statusCode == 201) {
        emit(LikeSuccessfully());
      } else {
        emit(LikeFailed());
      }
    } on SocketException {
      emit(LikeInternetError());
    } catch (e) {
      emit(LikeFailed());
    }
  }
}
