part of 'delete_fcm_token_cubit.dart';

@immutable
sealed class DeleteFcmTokenState {}

final class DeleteFcmTokenInitial extends DeleteFcmTokenState {}

final class DeleteFcmTokenLoading extends DeleteFcmTokenState {}

final class DeleteFcmTokenSuccess extends DeleteFcmTokenState {}

final class DeleteFcmTokenFailed extends DeleteFcmTokenState {}
