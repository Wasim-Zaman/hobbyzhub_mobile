part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ChatSendMessageEvent extends ChatEvent {
  final MessageModel message;
  ChatSendMessageEvent({required this.message});
}

class ChatReceiveMessageEvent extends ChatEvent {
  final MessageModel message;
  ChatReceiveMessageEvent({required this.message});
}

class ChatCreateNewPrivateCatEvent extends ChatEvent {
  final String otherUserId;
  ChatCreateNewPrivateCatEvent({required this.otherUserId});
}

class ChatGetPeoplesEvent extends ChatEvent {
  final int page, size;
  ChatGetPeoplesEvent({
    required this.page,
    required this.size,
  });
}

class ChatGetLocalMessagesEvent extends ChatEvent {
  final String chatId;
  ChatGetLocalMessagesEvent({required this.chatId});
}

class ChatSetLocalMessageEvent extends ChatEvent {
  final MessageModel message;
  final String chatId;
  ChatSetLocalMessageEvent({required this.message, required this.chatId});
}

class ChatGetMessagesEvent extends ChatEvent {
  final String chatId;
  final int page, size;
  ChatGetMessagesEvent(this.page, this.size, {required this.chatId});
}
