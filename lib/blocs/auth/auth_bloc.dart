import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/auth/auth_controller.dart';
import 'package:hobbyzhub/models/auth/auth_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:nb_utils/nb_utils.dart';

part 'auth_events_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    // Handle Events

    // Handle Register Event
    on<AuthEventRegister>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response = await AuthController.register(
            event.email,
            event.password,
          );
          emit(AuthRegistrationSuccessState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Send Verification Message Event
    on<AuthEventSendVerificationEmail>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          // generate 4 digits random otp
          final otp = Random.secure().nextInt(9999);
          // storing otp in the local database
          await UserSecureStorage.setOtp(otp.toString());
          final response = await AuthController.sendVerificaionMail(
            event.email,
            otp,
          );
          emit(AuthSendVerificationState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Handle email verification
    on<AuthEventVerifyEmail>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response = await AuthController.verifyAccount(event.email);
          emit(AuthVerificationState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Handle Login Event
    on<AuthEventLogin>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.login(event.email, event.password);
          emit(AuthLoginState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });
  }
}
