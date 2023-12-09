part of 'get_post_cubit.dart';

@immutable
sealed class GetPostState {}

final class GetPostInitial extends GetPostState {}

final class GetPostLoading extends GetPostState {}

final class GetPostLoaded extends GetPostState {
  final List<PostModel> postsList;

  GetPostLoaded({required this.postsList});
}

final class GetPostFailed extends GetPostState {}

final class GetPostInternetError extends GetPostState {}
