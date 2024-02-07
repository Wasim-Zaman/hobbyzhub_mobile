import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/auth/auth_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/auth/complete_profile_model.dart';
import 'package:hobbyzhub/utils/media_utils.dart';
import 'package:image_picker/image_picker.dart';
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
          final response =
              await AuthController.sendSignupVerificationMail(event.email);
          emit(AuthSendVerificationState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    on<AuthEventVerifyOtp>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.verifyOtpForBoth(event.email, event.otp);
          emit(AuthVerifyOtpState(response: response));
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

    // Handle complete profile event
    on<AuthEventCompleteProfile>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.completeProfile(model: event.model);
          emit(AuthCompleteProfileState(response: response));
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

    // Handle forget password event
    on<AuthEventSendVerificationForPasswordReset>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.sendVerificaionMailForPasswordChange(
                  event.email);
          emit(AuthSendVerificationForPasswordResetState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Change password after otp verification event handling
    on<AuthEventChangePasswordAfterOtpVerification>((event, emit) async {
      emit(AuthLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (networkStatus == true) {
          final response =
              await AuthController.changePassword(event.email, event.password);
          emit(AuthChangePasswordAfterOtpVerificationState(response: response));
        } else {
          throw Exception("No Internet Connection");
        }
      } catch (e) {
        emit(AuthStateFailure(message: e.toString()));
      }
    });

    // Pick image event
    on<AuthEventImagePicker>((event, emit) {
      MediaUtils.pickImage(event.imageSource).then((value) {
        if (value != null) {
          final File img = value;
          emit(AuthImagePickerState(image: img));
        } else {
          emit(AuthImagePickerState(image: null));
        }
      });
    });

    // Session Handling
    on<AuthRefreshTokenEvent>((event, emit) async {
      emit(AuthRefreshTokenLoading());
      try {
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await AuthController.refreshToken();
          emit(AuthRefreshTokenSuccess(response: response));
        } else {
          emit(AuthRefreshTokenError(message: "No Internet Connection"));
        }
      } catch (error) {
        emit(AuthRefreshTokenError(message: error.toString()));
      }
    });
  }
}
