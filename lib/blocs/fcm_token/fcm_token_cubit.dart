import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hobbyzhub/controllers/auth/auth_controller.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:meta/meta.dart';

part 'fcm_token_state.dart';

class FcmTokenCubit extends Cubit<FcmTokenState> {
  FcmTokenCubit() : super(FcmTokenInitial());

  registerFcmToekn() async {
    emit(FcmTokenLoading());

    try {
      final userId = await UserSecureStorage.fetchUserId();
      String? token = await FirebaseMessaging.instance.getToken();

      var response = await AuthController.registerFcmToken(token!, userId!);

      if (response.statusCode == 200) {
        emit(FcmTokenSuccess());
      }
    } catch (e) {
      emit(FcmTokenFailed());
    }
  }
}
