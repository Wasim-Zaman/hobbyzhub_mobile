part of 'help_center_cubit.dart';

@immutable
sealed class HelpCenterState {}

final class HelpCenterInitial extends HelpCenterState {}

final class HelpCenterLoading extends HelpCenterState {}

final class HelpCenterSuccess extends HelpCenterState {}

final class HelpCenterFailed extends HelpCenterState {}

final class HelpCenterInternetError extends HelpCenterState {}

final class HelpCenterTimeOut extends HelpCenterState {}
