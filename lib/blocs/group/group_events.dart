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

class GroupGetChatsEvent extends GroupEvent {
  final String? memberId;
  GroupGetChatsEvent({this.memberId});
}

class GroupGetMoreChatsEvent extends GroupEvent {
  final int page;
  final int size;
  GroupGetMoreChatsEvent({required this.page, required this.size});
}

class GroupGetMessagesEvent extends GroupEvent {
  final String groupId;
  final int page, size;
  GroupGetMessagesEvent(this.page, this.size, {required this.groupId});
}

class GroupReceiveMessagesEvent extends GroupEvent {
  final String groupId;
  final MessageModel message;
  GroupReceiveMessagesEvent({required this.groupId, required this.message});
}

class GroupGetLocalMessagesEvent extends GroupEvent {
  final String groupId;
  GroupGetLocalMessagesEvent({required this.groupId});
}
