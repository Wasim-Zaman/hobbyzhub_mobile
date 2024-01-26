import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/users/user_controller.dart';
import 'package:hobbyzhub/models/user/user_profile_model.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  UserController userController = UserController();

  getProfileInfo(userId) async {
    emit(GetProfileLoading());
    try {
      var profileBody = {"userId": "f08fe244157a"};
      var response = await userController.getUserProfile(profileBody);
      log(response.body);

      if (response.statusCode == 200) {
        var userData = UserProfileModel.fromJson(jsonDecode(response.body));

        emit(GetProfileLoaded(userProfile: [userData]));
      } else {
        emit(GetProfileFailed());
      }
    } on SocketException {
      emit(GetProfileInternetError());
    } catch (e) {
      print(e);
      emit(GetProfileFailed());
    }
  }
}
