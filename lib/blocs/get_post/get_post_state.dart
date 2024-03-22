part of 'get_post_cubit.dart';

sealed class GetPostState {}

final class GetPostInitial extends GetPostState {}

final class GetPostLoading extends GetPostState {
  final List<PostModel> postsList;

  GetPostLoading({required this.postsList});
}

final class GetPostLoaded extends GetPostState {
  final List<PostModel> postsList;

  GetPostLoaded({required this.postsList});
}

final class GetPostEmpty extends GetPostState {}

final class GetPostFailed extends GetPostState {}

final class GetPostInternetError extends GetPostState {}
