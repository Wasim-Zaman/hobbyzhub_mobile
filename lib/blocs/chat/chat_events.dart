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
