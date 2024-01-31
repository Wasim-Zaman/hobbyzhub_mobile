import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/users/user_controller.dart';
import 'package:hobbyzhub/models/user/user_post_model.dart';
import 'package:meta/meta.dart';

part 'third_user_post_state.dart';

class ThirdUserCubit extends Cubit<ThirdUserState> {
  ThirdUserCubit() : super(ThirdUserInitial());

  UserController userController = UserController();

  getPosts(userId) async {
    emit(ThirdUserLoading());
    try {
      var profileBody = {"userId": userId};
      var response = await userController.getUserPost(profileBody);

      if (response.statusCode == 200) {
        var userData = UserPostModel.fromJson(jsonDecode(response.body));

        emit(ThirdUserLoaded(thirdUserPost: [userData]));
      } else {
        emit(ThirdUserFailed());
      }
    } on SocketException {
      emit(ThirdUserInternetError());
    } catch (e) {
      emit(ThirdUserFailed());
    }
  }
}
