part of 'delete_post_cubit.dart';

@immutable
sealed class DeletePostState {}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostLoading extends DeletePostState {}

final class DeletePostLoaded extends DeletePostState {}

final class DeletePostFailed extends DeletePostState {}

final class DeletePostInternetError extends DeletePostState {}
