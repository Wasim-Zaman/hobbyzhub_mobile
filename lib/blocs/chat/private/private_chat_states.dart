part of 'private_chat_cubit.dart';

abstract class PrivateChatState {}

final class PrivateChatInitial extends PrivateChatState {}

final class PrivateChatLoading extends PrivateChatState {}

final class PrivateChatError extends PrivateChatState {
  final String message;

  PrivateChatError({required this.message});
}

final class PrivateChatCreate extends PrivateChatState {
  final PrivateChat chat;

  PrivateChatCreate({required this.chat});
}
