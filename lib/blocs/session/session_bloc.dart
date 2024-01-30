import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

part 'session_events.dart';
part 'session_states.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  SessionBloc() : super(SessionInitial()) {
    on<SessionRefreshToken>((event, emit) async {
      emit(SessionLoading());
      try {
        // TODO: Controller logic here
        emit(SessionSuccess(response: {
          'isVerified': true,
          'token': await UserSecureStorage.fetchToken(),
          'newUser': false,
          'categoryStatus': true
        }));
      } catch (err) {
        emit(SessionFailure(message: err.toString()));
      }
    });
  }
}
