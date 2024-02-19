part of 'unlike_post_cubit.dart';

@immutable
sealed class UnlikePostState {}

final class UnlikePostInitial extends UnlikePostState {}

final class UnLikeLoading extends UnlikePostState {}

final class UnLikeSuccessfully extends UnlikePostState {}

final class UnLikeFailed extends UnlikePostState {}

final class UnLikeInternetError extends UnlikePostState {}

final class UnLikeTimout extends UnlikePostState {}
