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

class ChatGetFromServerMessageEvent extends ChatEvent {
  final String chatId;
  ChatGetFromServerMessageEvent({required this.chatId});
}
