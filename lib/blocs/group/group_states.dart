part of 'group_bloc.dart';

abstract class GroupState {}

class GroupInitialState extends GroupState {}

class GroupLoadingState extends GroupState {}

class GroupSuccessState extends GroupState {
  final String message;
  GroupSuccessState({required this.message});
}

class GroupErrorState extends GroupState {
  final String message;
  GroupErrorState({required this.message});
}

class GroupCreateMediaState extends GroupState {
  final String mediaUrl;
  GroupCreateMediaState({required this.mediaUrl});
}

class GroupCreateGroupState extends GroupState {}
