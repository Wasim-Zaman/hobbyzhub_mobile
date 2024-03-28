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

class GroupCreateGroupState extends GroupState {
  final GroupChat group;
  GroupCreateGroupState({required this.group});
}

class GroupGetChatsState extends GroupState {
  final List<GroupModel> chats;
  GroupGetChatsState({required this.chats});
}

class GroupReceiveMessageState extends GroupState {
  final MessageModel message;
  GroupReceiveMessageState({required this.message});
}

class GroupGetLocalMessagesState extends GroupState {
  final List<MessageModel> messages;
  GroupGetLocalMessagesState({required this.messages});
}

class GroupGetDetailsState extends GroupState {
  final GroupModel group;
  GroupGetDetailsState({required this.group});
}

class GroupAddMemberState extends GroupState {}
