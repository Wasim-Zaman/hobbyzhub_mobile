part of 'third_user_post_cubit.dart';

@immutable
sealed class ThirdUserState {}

final class ThirdUserInitial extends ThirdUserState {}

final class ThirdUserLoading extends ThirdUserState {}

final class ThirdUserLoaded extends ThirdUserState {
  final List<UserPostModel> thirdUserPost;

  ThirdUserLoaded({required this.thirdUserPost});
}

final class ThirdUserFailed extends ThirdUserState {}

final class ThirdUserInternetError extends ThirdUserState {}
