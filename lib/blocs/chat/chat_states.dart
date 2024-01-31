part of 'chat_bloc.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatCreatePrivateChatLoadingState extends ChatState {}

class ChatConnectedState extends ChatState {}

class ChatDisconnectedState extends ChatState {}

class ChatMessageReceivedState extends ChatState {
  final List<MessageModel> messages;
  ChatMessageReceivedState({required this.messages});
}

class ChatMessageSentState extends ChatState {
  final List<MessageModel> messages;
  ChatMessageSentState({required this.messages});
}

class ChatErrorState extends ChatState {
  final String message;

  ChatErrorState({required this.message});
}

class ChatCreatePrivateSuccessState extends ChatState {
  final ChatModel chat;
  ChatCreatePrivateSuccessState({required this.chat});
}

class ChatGetSuccessState extends ChatState {
  final List<ChatModel> chats;

  ChatGetSuccessState({required this.chats});
}
