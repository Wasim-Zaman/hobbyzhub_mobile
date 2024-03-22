import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/get_post/get_post_controller.dart';
import 'package:hobbyzhub/models/post_model/post_model.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostCubit() : super(GetPostInitial());

  GetPostController getPostController = GetPostController();

  List<PostModel> postModelList = [];

  getPostList() async {
    emit(GetPostLoading(postsList: postModelList));
    try {
      var response = await getPostController.getPosts();
      log(response.body);

      if (response.statusCode == 200) {
        var postList = PostModel.fromJson(jsonDecode(response.body));
        postModelList = [postList];
        emit(GetPostLoaded(postsList: [postList]));
      } else {
        postModelList = [];
        emit(GetPostFailed());
      }
    } on SocketException {
      emit(GetPostInternetError());
    } catch (e) {
      print(e);
      emit(GetPostFailed());
    }
  }
}
