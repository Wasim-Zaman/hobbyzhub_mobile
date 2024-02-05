import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/update_profile/update_profile_controller.dart';

import 'package:meta/meta.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  UpdateProfileController updateProfileController = UpdateProfileController();

  updateProfile(image, userName, bio, dob) async {
    emit(UpdateProfileLoading());
    try {
      var response = await updateProfileController.completeProfile(
          image, userName, bio, dob);

      if (response.statusCode == 201) {
        emit(UpdateProfileSuccessfully());
      } else {
        print(response.statusCode);
        emit(UpdateProfileFailed());
      }
    } on SocketException {
      emit(UpdateProfileInternetError());
    } catch (e) {
      print(e);
      emit(UpdateProfileFailed());
    }
  }
}
