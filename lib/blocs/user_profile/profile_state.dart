part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileLoading extends ProfileState {}

final class GetProfileLoaded extends ProfileState {
  final List<UserProfileModel> userProfile;

  GetProfileLoaded({required this.userProfile});
}

final class GetProfileFailed extends ProfileState {}

final class GetProfileInternetError extends ProfileState {}
