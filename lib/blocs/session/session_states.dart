part of 'session_bloc.dart';

abstract class SessionState {}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionSuccess extends SessionState {
  final Map response;
  SessionSuccess({required this.response});
}

class SessionFailure extends SessionState {
  final String message;
  SessionFailure({required this.message});
}
