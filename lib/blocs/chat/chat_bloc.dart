import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hobbyzhub/controllers/chat/chat_controller.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'chat_events.dart';
part 'chat_states.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  static ChatBloc get(context) => context.read<ChatBloc>();
  ChatBloc() : super(ChatInitialState()) {
    final List<MessageModel> messages = [];
    on<ChatSendMessageEvent>((event, emit) {
      messages.insert(0, event.message);
      emit(ChatMessageSentState(message: event.message));
    });

    on<ChatReceiveMessageEvent>((event, emit) {
      messages.insert(0, event.message);
      emit(ChatMessageReceivedState(message: event.message));
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

    on<ChatSendNewMessageEvent>((event, emit) async {
      try {
        // emit(ChatSendNewMessageLoadingState());
        var networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(ChatSendNewMessageFailure(
              errorMessage: "No internet connection"));
        } else {
          final response = await ChatController.sendMessage(
            message: event.message,
            createMetadataRequest: event.createMetadataRequest,
            room: event.room,
            media: event.media,
            mediaType: event.mediaType,
          );
          if (response.data != null) {
            emit(ChatSendNewMessageSuccessState());
          } else {
            emit(ChatSendNewMessageFailure(errorMessage: 'No chat found'));
          }
        }
      } catch (err) {
        emit(ChatSendNewMessageFailure(errorMessage: err.toString()));
      }
    });

    on<ChatGetPeoplesEvent>((event, emit) async {
      try {
        emit(ChatLoadingState());
        var networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(ChatErrorState(message: "No internet connection"));
          return;
        }
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

    on<ChatGetMessagesEvent>((event, emit) async {
      emit(ChatGetMessagesFromServerLoadingState());
      try {
        final response = await ChatController.getServerMessages(
          event.chatId,
          page: event.page,
          size: event.size,
        );
        var network = await isNetworkAvailable();
        if (network) {
          if (response.data.isNotEmpty) {
            emit(ChatGetMessagesSuccessState(messages: response.data));
          } else {
            emit(ChatMessagesEmptyState());
          }
        } else {
          emit(
            ChatGetMessagesFailureState(errorMessage: "No internet connection"),
          );
        }
      } catch (error) {
        emit(ChatGetMessagesFailureState(errorMessage: error.toString()));
      }
    });

    on<ChatGetLocalMessagesEvent>((event, emit) async {
      // emit(ChatGetLocalMessagesLoadingState());
      var chatBox = await Hive.openBox<MessageModel>(event.chatId);
      emit(ChatGetLocalMessagesSuccessState(messages: chatBox.values.toList()));
      chatBox.close();
    });

    on<ChatSetLocalMessageEvent>((event, emit) async {
      var chatBox = await Hive.openBox<MessageModel>(event.chatId);
      chatBox.add(event.message);
      // If there are more than 100 messages, remove the oldest one
      if (chatBox.length > 100) {
        chatBox.deleteAt(0);
      }
      chatBox.close();
    });
  }
}
