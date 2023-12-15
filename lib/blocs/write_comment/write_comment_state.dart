part of 'write_comment_cubit.dart';

@immutable
sealed class WriteCommentState {}

final class WriteCommentInitial extends WriteCommentState {}

final class WriteCommentLoading extends WriteCommentState {}

final class WriteCommentSuccessfully extends WriteCommentState {}

final class WriteCommentFailed extends WriteCommentState {}

final class WriteCommentInternetError extends WriteCommentState {}

final class WriteCommentTimout extends WriteCommentState {}
