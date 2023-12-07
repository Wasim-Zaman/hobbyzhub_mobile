import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/get_post/get_post_controller.dart';
import 'package:meta/meta.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());

  GetPostController deletePostController = GetPostController();

  deletePost(postId) async {
    emit(DeletePostLoading());
    try {
      var response = await deletePostController.deletePosts(postId);
      print(response.statusCode);

      if (response.statusCode == 200) {
        emit(DeletePostLoaded());
      }
    } on SocketException {
      emit(DeletePostInternetError());
    } catch (e) {
      print(e);
      emit(DeletePostFailed());
    }
  }
}
