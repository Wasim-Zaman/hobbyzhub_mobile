part of 'f_and_f_bloc.dart';

// Events
abstract class FAndFEvent {}

class FAndFInitialFollowersEvent extends FAndFEvent {}

class FAndFMoreFollowersEvent extends FAndFEvent {
  int page, size;
  FAndFMoreFollowersEvent({required this.page, required this.size});
}

class FAndFInitialFollowingEvent extends FAndFEvent {}

class FAndFMoreFollowingEvent extends FAndFEvent {}

class FAndFFollowUnfollowEvent extends FAndFEvent {
  final String otherUserId;
  FAndFFollowUnfollowEvent({required this.otherUserId});
}

class FAndFCheckFollowingEvent extends FAndFEvent {
  final String otherUserId;
  FAndFCheckFollowingEvent({required this.otherUserId});
}

// States
abstract class FAndFState {}

class FAndFInitialState extends FAndFState {}

class FAndFLoadingState extends FAndFState {}

class FAndFInitialFollowersState extends FAndFState {
  ApiResponse response;
  FAndFInitialFollowersState({required this.response});
}

class FAndFInitialFollowingState extends FAndFState {
  final ApiResponse response;

  FAndFInitialFollowingState({required this.response});
}

class FAndFMoreFollowingState extends FAndFState {
  final ApiResponse response;

  FAndFMoreFollowingState({required this.response});
}

class FAndFFollowUnfollowState extends FAndFState {
  final ApiResponse response;

  FAndFFollowUnfollowState({required this.response});
}

class FAndFCheckState extends FAndFState {
  final Map response;

  FAndFCheckState({required this.response});
}

class FAndFErrorState extends FAndFState {
  String message;
  FAndFErrorState({this.message = 'Something went wrong!'});
}
