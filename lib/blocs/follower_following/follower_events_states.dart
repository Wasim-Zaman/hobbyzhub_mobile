part of 'follower_bloc.dart';

// Events
abstract class FollowerEvent {}

class FollowerGetInitialEvent extends FollowerEvent {}

// States
abstract class FollowerState {}

class FollowerInitialState extends FollowerState {}

class FollowerLoadingState extends FollowerState {}

class FollowerGetInitialState extends FollowerState {
  ApiResponse response;
  FollowerGetInitialState({required this.response});
}

class FollowerErrorState extends FollowerState {
  String message;
  FollowerErrorState({this.message = 'Something went wrong!'});
}
