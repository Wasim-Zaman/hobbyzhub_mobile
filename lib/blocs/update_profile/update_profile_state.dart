part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdateProfileLoading extends UpdateProfileState {}

final class UpdateProfileSuccessfully extends UpdateProfileState {}

final class UpdateProfileFailed extends UpdateProfileState {}

final class UpdateProfileInternetError extends UpdateProfileState {}

final class UpdateProfileTimout extends UpdateProfileState {}
