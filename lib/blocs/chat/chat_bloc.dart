import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/chat/chat_controller.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:nb_utils/nb_utils.dart';

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
    on<ChatCreateNewPrivateCatEvent>((event, emit) async {
      try {
        emit(ChatCreatePrivateChatLoadingState());
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response =
              await ChatController.startPrivateChat(event.otherUserId);
          if (response.data != null) {
            emit(ChatCreatePrivateSuccessState(chat: response.data!));
          } else {
            emit(ChatCreatePrivateErrorState(message: 'No chat found'));
          }
        } else {
          emit(ChatCreatePrivateErrorState(message: 'No internet connection'));
        }
      } catch (err) {
        emit(ChatCreatePrivateErrorState(message: err.toString()));
      }
    });
    on<ChatGetPeoplesEvent>((event, emit) async {
      try {
        emit(ChatLoadingState());
        final response = await ChatController.getAllChats(
          page: event.page,
          size: event.size,
        );

        if (response.data.isNotEmpty) {
          emit(ChatGetSuccessState(chats: response.data));
        } else {
          emit(ChatErrorState(message: 'No messages found'));
        }
      } catch (err) {
        emit(ChatErrorState(message: err.toString()));
      }
    });
  }
}
