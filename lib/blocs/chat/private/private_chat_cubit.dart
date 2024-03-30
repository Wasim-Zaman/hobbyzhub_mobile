import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/chat/chat_controller.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:hobbyzhub/models/message/message.dart';
import 'package:hobbyzhub/utils/app_exceptions.dart';
import 'package:nb_utils/nb_utils.dart';

part 'private_chat_states.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  int limit = 100;

  void createPrivateChat(String otherUserId) async {
    emit(ChatCreatePrivateLoading());
    try {
      // check internet connection
      if (await isNetworkAvailable()) {
        var res = await ChatController.startPrivateChat(otherUserId);
        emit(ChatCreatePrivateSuccess(chat: res.data));
      } else {
        emit(ChatCreatePrivateError(message: 'No internet connection'));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ChatCreatePrivateError(message: err.toString()));
      } else {
        emit(ChatCreatePrivateError(
            message: "An error occurred while creating private chat"));
      }
    }
  }

  void createGroupChat(Map<dynamic, dynamic> body) async {
    emit(ChatCreatePrivateLoading());
    try {
// check internet connection
      var networkStatus = await isNetworkAvailable();
      if (networkStatus) {
        File? groupImage = body['groupImage'];
        String title = body['title'];
        String groupDescription = body['groupDescription'];
        List<Map<String, dynamic>> adminIds = body['adminIds'];
        List<Map<String, dynamic>> participantRequests =
            body['participantRequests'];

        final response = await ChatController.createGroupChat(
          groupImage: groupImage,
          adminIds: adminIds,
          participantIds: participantRequests,
          title: title,
          description: groupDescription,
        );

        emit(ChatCreateGroupSuccess(group: response.data));
      } else {
        emit(ChatCreateGroupError(message: 'No internet connection'));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ChatCreatePrivateError(message: err.toString()));
      } else {
        emit(ChatCreatePrivateError(
            message: "An error occurred while creating group chat"));
      }
    }
  }

  void sendMessage({
    String mediaType = "TEXT",
    required String message,
    required String room,
    File? media,
    required Map createMetadataRequest,
  }) async {
    emit(ChatSendMessageLoading());
    try {
      var networkStatus = await isNetworkAvailable();
      if (!networkStatus) {
        emit(ChatSendMessageError(message: "Network is not available"));
      } else {
        await ChatController.sendMessage(
          message: message,
          createMetadataRequest: createMetadataRequest,
          room: room,
          media: media,
          mediaType: mediaType,
        );
        emit(ChatSendMessageSuccess());
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ChatSendMessageError(message: err.toString()));
      } else {
        emit(
          ChatSendMessageError(
            message: "An error occurred while sending message",
          ),
        );
      }
    }
  }

  void getMessages({required String room, required int from}) async {
    emit(ChatGetMessagesLoading());
    try {
      var networkStatus = await isNetworkAvailable();
      if (!networkStatus) {
        emit(ChatGetMessagesError(message: "Network is not available"));
      } else {
        // var res = await ChatController.getServerMessages(room, from: from);
        // emit(ChatGetMessagesSuccess(messages: res.data));
        await Future.delayed(const Duration(seconds: 1));
        emit(ChatGetMessagesSuccess(messages: []));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ChatGetMessagesError(message: err.toString()));
      } else {
        emit(
          ChatGetMessagesError(
            message: "An error occurred while fetching messages",
          ),
        );
      }
    }
  }
}
