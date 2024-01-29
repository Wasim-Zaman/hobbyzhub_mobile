part of 'user_post_cubit.dart';

@immutable
sealed class UserPostState {}

final class UserPostInitial extends UserPostState {}

final class UserPostLoading extends UserPostState {}

final class UserPostLoaded extends UserPostState {
  final List<UserPostModel> userPost;

  UserPostLoaded({required this.userPost});
}

final class UserPostFailed extends UserPostState {}

final class UserPostInternetError extends UserPostState {}
