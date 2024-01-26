part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatConnectedState extends ChatState {}

class ChatDisconnectedState extends ChatState {}

class ChatMessageReceivedState extends ChatState {
  ChatMessageReceivedState({required List<MessageModel> messages});
}

class ChatMessageSentState extends ChatState {
  final List<MessageModel> messages;
  ChatMessageSentState({required this.messages});
}

class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState({required this.message});
}
