part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  AuthEventLogin({required this.email, required this.password});
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  AuthEventRegister({required this.email, required this.password});
}

class AuthEventSendVerificationEmail extends AuthEvent {
  final String email;

  AuthEventSendVerificationEmail({required this.email});
}

class AuthEventVerifyEmail extends AuthEvent {
  final String email;

  AuthEventVerifyEmail({required this.email});
}

// States
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthRegistrationSuccessState extends AuthState {
  final AuthModel response;
  AuthRegistrationSuccessState({required this.response});
}

class AuthSendVerificationState extends AuthState {
  final AuthModel response;
  AuthSendVerificationState({required this.response});
}

class AuthVerificationState extends AuthState {
  final AuthModel response;
  AuthVerificationState({required this.response});
}

class AuthLoginState extends AuthState {
  final AuthModel response;
  AuthLoginState({required this.response});
}

class AuthStateFailure extends AuthState {
  final String message;

  AuthStateFailure({required this.message});
}
