part of 'private_chat_cubit.dart';

abstract class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

// Loading states
final class ChatCreatePrivateLoading extends ChatState {}

final class ChatCreateGroupLoading extends ChatState {}

final class ChatSendMessageLoading extends ChatState {}

// Failure states
final class ChatCreatePrivateError extends ChatState {
  final String message;

  ChatCreatePrivateError({required this.message});
}

final class ChatCreateGroupError extends ChatState {
  final String message;
  ChatCreateGroupError({required this.message});
}

final class ChatSendMessageError extends ChatState {}

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
