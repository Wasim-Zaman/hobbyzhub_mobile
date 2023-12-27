part of 'likes_cubit.dart';

@immutable
sealed class LikesState {}

final class LikesInitial extends LikesState {}

final class LikeLoading extends LikesState {}

final class LikeSuccessfully extends LikesState {}

final class LikeFailed extends LikesState {}

final class LikeInternetError extends LikesState {}

final class LikeTimout extends LikesState {}
