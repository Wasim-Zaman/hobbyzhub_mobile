part of 'createpost_cubit.dart';

@immutable
sealed class CreatepostState {}

final class CreatepostInitial extends CreatepostState {}

final class CreatepostLoading extends CreatepostState {}

final class CreatepostLoaded extends CreatepostState {}

final class CreatepostFailed extends CreatepostState {}

final class CreatepostInternetError extends CreatepostState {}

final class CreatepostTimout extends CreatepostState {}
