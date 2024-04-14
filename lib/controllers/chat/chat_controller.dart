import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:hobbyzhub/models/message/message.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/utils/app_exceptions.dart';
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
    log("Create private chat status: ${response.statusCode}");
    log(response.body);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      return ApiResponse.fromJson(
        responseBody,
        (data) => PrivateChat.fromJson(responseBody['data']),
      );
    } else {
      throw ErrorException(responseBody['message']);
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
      (data) => GroupChat.fromJson(responseJson['data']),
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
        "${ChatUrl.sendMessage}?mediaType=$mediaType&message=$message&room=$room";

    final token = await UserSecureStorage.fetchToken();

    final request = http.MultipartRequest('POST', Uri.parse(url));

    if (media != null) {
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "multipart/form-data",
      });
    } else {
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });
    }

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
    final responseString = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseString);
    if (responseJson['success'] == true) {
      return ApiResponse.fromJson(
        responseJson,
        (data) => MessageModel.fromJson(responseJson['data']),
      );
    } else {
      throw ErrorException(responseJson['message']);
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
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> getServerMessages(String room,
      {required int from, int size = 100}) async {
    final url = ChatUrl.getMessages;
    final token = await UserSecureStorage.fetchToken();

    final body = {"room": room, "from": from, "size": size};
    print(body);
    print(token);

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await ApiManager.postRequest(body, url, headers: headers);
    log(response.statusCode.toString());
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      List<Message> messages = [];
      responseBody['data'].forEach((chat) {
        messages.add(Message.fromJson(chat));
      });
      return ApiResponse.fromJson(responseBody, (p0) => messages);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> makeMemberAnAdmin(memberId) async {
    final url = ChatUrl.makeMemberAdmin;
    final token = await UserSecureStorage.fetchToken();
    final body = {"participantId": memberId};
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      return ApiResponse.fromJson(responseBody, (p0) => null);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> removeMemberFromGroup(memberId) async {
    final url = ChatUrl.removeMember;
    final token = await UserSecureStorage.fetchToken();
    final body = {"participantId": memberId};
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      return ApiResponse.fromJson(responseBody, (p0) => null);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> addMemberToGroup(memberid) async {
    final url = ChatUrl.addMember;
    final token = await UserSecureStorage.fetchToken();
    final body = {"participantId": memberid};
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true && responseBody['status'] == 200) {
      return ApiResponse.fromJson(responseBody, (p0) => null);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }
}
