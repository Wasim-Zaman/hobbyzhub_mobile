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

class GroupGetChatsEvent extends GroupEvent {}

class GroupGetMoreChatsEvent extends GroupEvent {
  final int page;
  final int size;
  GroupGetMoreChatsEvent({required this.page, required this.size});
}

class GroupGetMessagesEvent extends GroupEvent {
  final String groupId;
  GroupGetMessagesEvent({required this.groupId});
}
