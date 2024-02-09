part of 'group_bloc.dart';

abstract class GroupEvent {}

class GroupCreateEvent extends GroupEvent {
  final Map body;

  GroupCreateEvent({required this.body});
}

class GroupCreateMediaEvent extends GroupEvent {
  final File media;
  GroupCreateMediaEvent({required this.media});
}
