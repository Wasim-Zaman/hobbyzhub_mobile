part of 'explore_cubit.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

// Loading states
final class ExploreGetRandomPostsLoading extends ExploreState {}

final class ExploreGetRandomUsersLoading extends ExploreState {}

final class ExploreGetMoreRandomPostsLoading extends ExploreState {}

final class ExploreGetMoreRandomUsersLoading extends ExploreState {}

final class ExploreGetSubscribedHobbyzLoading extends ExploreState {}

final class ExploreGetMoreSubscribedHobbyzLoading extends ExploreState {}

final class ExploreGetHobbyPostsLoading extends ExploreState {}

final class ExploreGetMoreHobbyzPostsLoading extends ExploreState {}
// Success states

final class ExploreGetRandomPostsSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetRandomPostsSuccess({required this.res});
}

final class ExploreGetRandomUsersSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetRandomUsersSuccess({required this.res});
}

final class ExploreGetMoreRandomPostsSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetMoreRandomPostsSuccess({required this.res});
}

final class ExploreGetMoreRandomUsersSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetMoreRandomUsersSuccess({required this.res});
}

final class ExploreGetSubscribedHobbyzSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetSubscribedHobbyzSuccess({required this.res});
}

final class ExploreGetMoreSubscribedHobbyzSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetMoreSubscribedHobbyzSuccess({required this.res});
}

final class ExploreGetHobbyPostsSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetHobbyPostsSuccess({required this.res});
}

final class ExploreGetMoreHobbyzPostsSuccess extends ExploreState {
  final ApiResponse res;
  ExploreGetMoreHobbyzPostsSuccess({required this.res});
}

//! Error states
final class ExploreGetRandomPostsError extends ExploreState {
  final String message;
  ExploreGetRandomPostsError({required this.message});
}

final class ExploreGetRandomUsersError extends ExploreState {
  final String message;
  ExploreGetRandomUsersError({required this.message});
}

final class ExploreGetMoreRandomPostsError extends ExploreState {
  final String message;
  ExploreGetMoreRandomPostsError({required this.message});
}

final class ExploreGetMoreRandomUsersError extends ExploreState {
  final String message;
  ExploreGetMoreRandomUsersError({required this.message});
}

final class ExploreGetSubscribedHobbyzError extends ExploreState {
  final String message;
  ExploreGetSubscribedHobbyzError({required this.message});
}

final class ExploreGetMoreSubscribedHobbyzError extends ExploreState {
  final String message;
  ExploreGetMoreSubscribedHobbyzError({required this.message});
}

final class ExploreGetHobbyPostsError extends ExploreState {
  final String message;
  ExploreGetHobbyPostsError({required this.message});
}

// Empty states
final class ExploreGetRamdomPostsEmpty extends ExploreState {}

final class ExploreGetRandomUsersEmpty extends ExploreState {}

final class ExploreGetMoreRandomPostsEmpty extends ExploreState {}

final class ExploreGetMoreRandomUsersEmpty extends ExploreState {}

final class ExploreGetSubscribedHobbyzEmpty extends ExploreState {}

final class ExploreGetHobbyzPostsEmpty extends ExploreState {}
