import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/auth/auth_controller.dart';
import 'package:hobbyzhub/models/auth/registration_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'auth_events_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateInitial()) {
    // Handle Events

    // Handle Register Event
    on<AuthEventRegister>((event, emit) async {
      emit(AuthStateLoading());
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

    // Handle Login Event
    on<AuthEventLogin>((event, emit) {
      emit(AuthStateLoading());
    });
  }
}
