import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/models/message/message_model.dart';

part 'chat_events.dart';
part 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    final List<MessageModel> messages = [];
    on<ChatSendMessageEvent>((event, emit) {
      messages.add(event.message);
      emit(ChatMessageSentState(messages: messages));
    });
    on<ChatReceiveMessageEvent>((event, emit) {
      messages.add(event.message);
      emit(ChatMessageReceivedState(messages: messages));
    });
  }
}
