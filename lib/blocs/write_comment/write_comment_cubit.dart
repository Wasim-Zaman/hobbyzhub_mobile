import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/create_post/create_post.dart';
import 'package:meta/meta.dart';

part 'write_comment_state.dart';

class WriteCommentCubit extends Cubit<WriteCommentState> {
  WriteCommentCubit() : super(WriteCommentInitial());

  PostController postController = PostController();

  writeComment(
    postId,
    comment,
  ) async {
    emit(WriteCommentLoading());
    try {
      var response = await postController.writeCommentFunction(postId, comment);

      if (response.statusCode == 201) {
        emit(WriteCommentSuccessfully());
      } else {
        emit(WriteCommentFailed());
      }
    } on SocketException {
      emit(WriteCommentInternetError());
    } catch (e) {
      print(e);
      emit(WriteCommentFailed());
    }
  }
}
