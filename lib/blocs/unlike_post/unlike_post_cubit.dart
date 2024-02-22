import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/create_post/create_post.dart';
import 'package:meta/meta.dart';

part 'unlike_post_state.dart';

class UnlikePostCubit extends Cubit<UnlikePostState> {
  UnlikePostCubit() : super(UnlikePostInitial());

  PostController postController = PostController();

  createUnLike(likeId) async {
    emit(UnLikeLoading());
    try {
      var response = await postController.createuNLikeFunction(likeId);

      if (response.statusCode == 200) {
        emit(UnLikeSuccessfully());
      } else {
        emit(UnLikeFailed());
      }
    } on SocketException {
      emit(UnLikeInternetError());
    } catch (e) {
      emit(UnLikeFailed());
    }
  }
}
