import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/auth/auth_controller.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:meta/meta.dart';

part 'delete_fcm_token_state.dart';

class DeleteFcmTokenCubit extends Cubit<DeleteFcmTokenState> {
  DeleteFcmTokenCubit() : super(DeleteFcmTokenInitial());

  unRegisterFcmToken() async {
    emit(DeleteFcmTokenLoading());

    try {
      final userId = await UserSecureStorage.fetchUserId();

      var response = await AuthController.unRegisterFcmToken(userId!);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        emit(DeleteFcmTokenSuccess());
      }
    } catch (e) {
      emit(DeleteFcmTokenFailed());
    }
  }
}
