part of 'private_chat_cubit.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

// Loading states
final class ChatCreatePrivateLoading extends ChatState {}

final class ChatCreateGroupLoading extends ChatState {}

final class ChatSendMessageLoading extends ChatState {}

final class ChatGetMessagesLoading extends ChatState {}

final class ChatMakeMemberAdminLoading extends ChatState {}

final class ChatRemoveMemberFromGroupLoading extends ChatState {}

final class ChatAddMemberToGroupLoading extends ChatState {}

// ! Failure states
final class ChatCreatePrivateError extends ChatState {
  final String message;

  ChatCreatePrivateError({required this.message});
}

final class ChatCreateGroupError extends ChatState {
  final String message;
  ChatCreateGroupError({required this.message});
}

final class ChatSendMessageError extends ChatState {
  final String message;

  ChatSendMessageError({required this.message});
}

final class ChatGetMessagesError extends ChatState {
  final String message;

  ChatGetMessagesError({required this.message});
}

final class ChatMakeMemberAdminError extends ChatState {
  final String message;

  ChatMakeMemberAdminError({required this.message});
}

final class ChatRemoveMemberFromGroupError extends ChatState {
  final String message;
  ChatRemoveMemberFromGroupError({required this.message});
}

final class ChatAddMemberToGroupError extends ChatState {
  final String message;
  ChatAddMemberToGroupError({required this.message});
}

// Success states
final class ChatCreatePrivateSuccess extends ChatState {
  final PrivateChat chat;

  ChatCreatePrivateSuccess({required this.chat});
}

final class ChatCreateGroupSuccess extends ChatState {
  final GroupChat group;
  ChatCreateGroupSuccess({required this.group});
}

final class ChatSendMessageSuccess extends ChatState {}

final class ChatGetMessagesSuccess extends ChatState {
  final List<Message> messages;

  ChatGetMessagesSuccess({required this.messages});
}

final class ChatMakeMemberAdminSuccess extends ChatState {}

final class ChatRemoveMemberFromGroupSuccess extends ChatState {}

final class ChatAddMemberToGroupSuccess extends ChatState {}
