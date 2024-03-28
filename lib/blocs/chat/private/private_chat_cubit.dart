import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/chat/chat_controller.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:nb_utils/nb_utils.dart';

part 'private_chat_states.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

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
      emit(ChatCreatePrivateError(message: err.toString()));
    }
  }

  void createGroupChat(Map<dynamic, dynamic> body) async {
    emit(ChatCreatePrivateLoading());
    try {
      // check internet connection
      if (await isNetworkAvailable()) {
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
      emit(ChatCreatePrivateError(message: err.toString()));
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
    var networkStatus = await isNetworkAvailable();
    if (!networkStatus) {
      emit(ChatSendMessageError());
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
  }
}
