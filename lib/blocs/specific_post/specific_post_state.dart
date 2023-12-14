part of 'specific_post_cubit.dart';

@immutable
sealed class SpecificPostState {}

final class SpecificPostInitial extends SpecificPostState {}

final class SpecificPostLoading extends SpecificPostState {}

final class SpecificPostLoaded extends SpecificPostState {
  // final List<PostModel> specificPostsList;

  // SpecificPostLoaded({required this.specificPostsList});
}

final class SpecificPostFailed extends SpecificPostState {}

final class SpecificPostInternetError extends SpecificPostState {}
