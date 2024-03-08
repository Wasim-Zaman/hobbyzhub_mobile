part of 'get_stories_cubit.dart';

@immutable
sealed class GetStoriesState {}

final class GetStoriesInitial extends GetStoriesState {}

final class GetStoriesLoading extends GetStoriesState {
  final List<GetStoriesModel> storiesList;

  GetStoriesLoading({required this.storiesList});
}

final class GetStoriesLoaded extends GetStoriesState {
  final List<GetStoriesModel> storiesList;

  GetStoriesLoaded({required this.storiesList});
}

final class GetStoriesFailed extends GetStoriesState {}

final class GetStoriesInternetError extends GetStoriesState {}
