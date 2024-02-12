part of 'fcm_token_cubit.dart';

@immutable
sealed class FcmTokenState {}

final class FcmTokenInitial extends FcmTokenState {}

final class FcmTokenLoading extends FcmTokenState {}

final class FcmTokenSuccess extends FcmTokenState {}

final class FcmTokenFailed extends FcmTokenState {}
