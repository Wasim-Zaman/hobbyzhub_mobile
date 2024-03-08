part of 'create_story_cubit.dart';

@immutable
sealed class CreateStoryState {}

final class CreateStoryInitial extends CreateStoryState {}

final class CreatestoryLoading extends CreateStoryState {}

final class CreatestorySuccessfully extends CreateStoryState {}

final class CreatestoryFailed extends CreateStoryState {}

final class CreatestoryInternetError extends CreateStoryState {}

final class CreatestoryTimout extends CreateStoryState {}
