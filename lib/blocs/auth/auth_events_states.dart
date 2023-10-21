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

abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthRegistrationSuccessState extends AuthState {
  final RegistrationModel response;
  AuthRegistrationSuccessState({required this.response});
}

class AuthStateFailure extends AuthState {
  final String message;

  AuthStateFailure({required this.message});
}
