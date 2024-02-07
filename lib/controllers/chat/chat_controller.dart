import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/utils/app_date.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

abstract class ChatController {
  static startPrivateChat(String otherUserId) async {
    final url = ChatUrl.createPrivateChat;
    final token = await UserSecureStorage.fetchToken();
    final myUserId = await UserSecureStorage.fetchUserId();
    final body = {
      "dateTimeCreated": AppDate.generateTimeString(),
      "myUserId": myUserId,
      "otherUserId": otherUserId,
    };
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      return ApiResponse.fromJson(
        responseBody,
        (data) => ChatModel.fromJson(
          responseBody['data'],
        ),
      );
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<ApiResponse> getAllChats({int page = 0, int size = 20}) async {
    final url = ChatUrl.getChats;
    final token = await UserSecureStorage.fetchToken();
    final userId = await UserSecureStorage.fetchUserId();
    final body = {"participantId": userId, "page": page, "size": size};
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      List<ChatModel> chatModels = [];
      responseBody['data'].forEach((chat) {
        chatModels.add(ChatModel.fromJson(chat));
      });
      return ApiResponse.fromJson(responseBody, (p0) => chatModels);
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<ApiResponse> getServerMessages(String chatId,
      {int page = 0, int size = 100}) async {
    final url = ChatUrl.getServerMessages;
    final token = await UserSecureStorage.fetchToken();
    final body = {"chatId": chatId, "page": page, "size": size};
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    print(responseBody);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      List<MessageModel> messages = [];
      responseBody['data'].forEach((chat) {
        messages.add(MessageModel.fromJson(chat));
      });
      return ApiResponse.fromJson(responseBody, (p0) => messages);
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
