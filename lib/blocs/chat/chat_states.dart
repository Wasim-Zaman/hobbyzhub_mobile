part of 'chat_bloc.dart';

abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatLoadingState extends ChatStates {}

class ChatCreatePrivateChatLoadingState extends ChatStates {}

class ChatConnectedState extends ChatStates {}

class ChatDisconnectedState extends ChatStates {}

class ChatMessageReceivedState extends ChatStates {
  final MessageModel message;
  ChatMessageReceivedState({required this.message});
}

class ChatMessageSentState extends ChatStates {
  final MessageModel message;
  ChatMessageSentState({required this.message});
}

class ChatErrorState extends ChatStates {
  final String message;

  ChatErrorState({required this.message});
}

class ChatCreatePrivateSuccessState extends ChatStates {
  final ChatModel chat;
  ChatCreatePrivateSuccessState({required this.chat});
}

class ChatCreatePrivateErrorState extends ChatStates {
  final String message;
  ChatCreatePrivateErrorState({required this.message});
}

class ChatGetMessagesFromServerLoadingState extends ChatStates {}

class ChatGetLocalMessagesLoadingState extends ChatStates {}

class ChatGetMessagesSuccessState extends ChatStates {
  final List<MessageModel> messages;
  ChatGetMessagesSuccessState({required this.messages});
}

class ChatGetLocalMessagesSuccessState extends ChatStates {
  final List<MessageModel> messages;
  ChatGetLocalMessagesSuccessState({required this.messages});
}

class ChatMessagesEmptyState extends ChatStates {}

class ChatGetMessagesFailureState extends ChatStates {
  final String errorMessage;
  ChatGetMessagesFailureState({required this.errorMessage});
}

class ChatGetSuccessState extends ChatStates {
  final List<ChatModel> chats;

  ChatGetSuccessState({required this.chats});
}

// success states
class ChatSendNewMessageSuccessState extends ChatStates {}

// failure states
class ChatSendNewMessageFailure extends ChatStates {
  final String errorMessage;
  ChatSendNewMessageFailure({required this.errorMessage});
}
