part of 'following_bloc.dart';

// Events
abstract class FollowingEvent {}

class FollowingGetInitialEvent extends FollowingEvent {}

class FollowingGetMoreEvent extends FollowingEvent {}

class FollowingFollowUnfollowEvent extends FollowingEvent {
  final String otherUserId;
  FollowingFollowUnfollowEvent({required this.otherUserId});
}

class FollowingCheckEvent extends FollowingEvent {
  final String otherUserId;
  FollowingCheckEvent({required this.otherUserId});
}

// States
abstract class FollowingState {}

class FollowingInitialState extends FollowingState {}

class FollowingLoadingState extends FollowingState {}

class FollowingGetInitialState extends FollowingState {
  final ApiResponse response;

  FollowingGetInitialState({required this.response});
}

class FollowingGetMoreState extends FollowingState {
  final ApiResponse response;

  FollowingGetMoreState({required this.response});
}

class FollowingFollowUnfollowState extends FollowingState {
  final ApiResponse response;

  FollowingFollowUnfollowState({required this.response});
}

class FollowingCheckState extends FollowingState {
  final Map response;

  FollowingCheckState({required this.response});
}

class FollowingErrorState extends FollowingState {
  final String message;

  FollowingErrorState({required this.message});
}
