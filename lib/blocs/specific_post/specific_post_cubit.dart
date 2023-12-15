import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/get_post/get_post_controller.dart';
import 'package:hobbyzhub/models/post_model/specific_post_model.dart';
import 'package:meta/meta.dart';

part 'specific_post_state.dart';

class SpecificPostCubit extends Cubit<SpecificPostState> {
  SpecificPostCubit() : super(SpecificPostInitial());

  GetPostController specificPostController = GetPostController();

  specificPostInformation(postId) async {
    emit(SpecificPostLoading());
    try {
      var response = await specificPostController.specficPosts(postId);
      log(response.body.toString());
      if (response.statusCode == 200) {
        var postList = SpecificPostModel.fromJson(jsonDecode(response.body));
        emit(SpecificPostLoaded(specificPostsList: [postList]));
      }
    } on SocketException {
      emit(SpecificPostInternetError());
    } catch (e) {
      emit(SpecificPostFailed());
    }
  }
}
