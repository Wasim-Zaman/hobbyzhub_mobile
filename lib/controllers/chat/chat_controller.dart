import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class ChatController {
  static Future<ApiResponse> startPrivateChat(String otherUserId) async {
    final url = ChatUrl.createPrivateChat;
    final token = await UserSecureStorage.fetchToken();
    final myUserId = await UserSecureStorage.fetchUserId();
    final body = {
      "participantIds": [myUserId.toString(), otherUserId.toString()]
    };

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await ApiManager.postRequest(body, url, headers: headers);
    log(response.body);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      return ApiResponse.fromJson(
        responseBody,
        (data) => PrivateChat.fromJson(
          responseBody['data'],
        ),
      );
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<ApiResponse> createGroupChat({
    File? groupImage,
    required String title,
    required String description,
    String type = 'GROUP',
    required List<Map> participantIds,
    required List<Map> adminIds,
  }) async {
    // multi part request

    final token = await UserSecureStorage.fetchToken();
    final url =
        "${ChatUrl.createGroupChat}?title=$title&type=$type&groupDescription=$description";

    final request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    if (groupImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'groupImage',
        groupImage.path,
        filename: groupImage.path.split('/').last,
        // contentType: MediaType('image', 'jpeg'),
      ));
    }

    request.files.add(http.MultipartFile.fromString(
      'participantRequests',
      jsonEncode(participantIds),
      contentType:
          MediaType('application', 'json'), // specify the content type here
    ));

    request.files.add(http.MultipartFile.fromString(
      'adminIds',
      jsonEncode(adminIds),
      contentType:
          MediaType('application', 'json'), // specify the content type here
    ));

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseString);
    return ApiResponse.fromJson(
      responseJson,
      (data) => null /*PrivateChat.fromJson(responseJson['data']) */,
    );
  }

  static Future<ApiResponse> sendMessage({
    File? media,
    required String message,
    required String room,
    String mediaType = 'TEXT',
    required Map createMetadataRequest,
  }) async {
    final url =
        "${ChatUrl.createGroupChat}?mediaType=$mediaType&message=$message&room=$room";

    print(message);
    print(room);
    print(mediaType);
    print(createMetadataRequest);

    final token = await UserSecureStorage.fetchToken();

    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "multipart/form-data",
    });

    if (media != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'mediaUrl',
        media.path,
        filename: media.path.split('/').last,
        // contentType: MediaType('image', 'jpeg'),
      ));
    }
    request.files.add(http.MultipartFile.fromString(
      'createMetadataRequest',
      jsonEncode(createMetadataRequest),
      contentType:
          MediaType('application', 'json'), // specify the content type here
    ));

    final response = await request.send();
    print("Status code : ${response.statusCode}");
    final responseString = await response.stream.bytesToString();
    print(responseString);
    final responseJson = jsonDecode(responseString);
    return ApiResponse.fromJson(
      responseJson,
      (data) => null /*PrivateChat.fromJson(responseJson['data']) */,
    );
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
