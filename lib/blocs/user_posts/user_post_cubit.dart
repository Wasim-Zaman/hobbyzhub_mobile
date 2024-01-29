import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/users/user_controller.dart';
import 'package:hobbyzhub/models/user/user_post_model.dart';
import 'package:meta/meta.dart';

part 'user_post_state.dart';

class UserPostCubit extends Cubit<UserPostState> {
  UserPostCubit() : super(UserPostInitial());

  UserController userController = UserController();

  getPosts(userId) async {
    emit(UserPostLoading());
    try {
      var profileBody = {"userId": userId};
      var response = await userController.getUserPost(profileBody);

      if (response.statusCode == 200) {
        var userData = UserPostModel.fromJson(jsonDecode(response.body));

        emit(UserPostLoaded(userPost: [userData]));
      } else {
        emit(UserPostFailed());
      }
    } on SocketException {
      emit(UserPostInternetError());
    } catch (e) {
      emit(UserPostFailed());
    }
  }
}
