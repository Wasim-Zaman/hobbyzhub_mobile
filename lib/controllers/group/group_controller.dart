import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/group/group_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class GroupController {
  Future<Map> createMedia(File media) async {
    final url = GroupUrl.createMedia;
    final token = await UserSecureStorage.fetchToken();

    // create a multi part post request for the group
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('media', media.path));
    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    final responseJson = jsonDecode(responseString);
    return responseJson;
  }

  Future<ApiResponse> createNewGroup({required Map body}) async {
    final url = GroupUrl.createGroup;
    final token = await UserSecureStorage.fetchToken();
    var headers = <String, String>{
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);
    if (resBody['success'] && resBody['status'] == 200) {
      return ApiResponse.fromJson(
        resBody,
        (p0) => GroupModel.fromJson(resBody['data']),
      );
    } else {
      throw Exception(resBody['message']);
    }
  }

  Future<ApiResponse> getGroupChats({
    int page = 0,
    int size = 5,
    String? memberId,
  }) async {
    final url = GroupUrl.getChats;
    final token = await UserSecureStorage.fetchToken();
    final userId = await UserSecureStorage.fetchUserId();

    var body = {"memberId": memberId ?? userId, "page": page, "size": size};
    var headers = <String, String>{
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await ApiManager.postRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);

    if (resBody['success'] && resBody['status'] == 200) {
      List<GroupModel> groups = [];
      resBody['data'].forEach((group) {
        groups.add(GroupModel.fromJson(group));
      });
      return ApiResponse.fromJson(resBody, (p0) => groups);
    } else {
      throw Exception(resBody['message']);
    }
  }

  Future<ApiResponse> getGroupDetails(chatId) async {
    final url = GroupUrl.groupDetails;
    final token = await UserSecureStorage.fetchToken();

    var body = {"groupChatId": chatId};
    var headers = <String, String>{
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    var resBody = jsonDecode(response.body);

    if (resBody['success'] && resBody['status'] == 200) {
      return ApiResponse.fromJson(
        resBody,
        (p0) => GroupModel.fromJson(resBody['data']),
      );
    } else {
      throw Exception(resBody['message']);
    }
  }

  Future<ApiResponse> addMemberToTheGroup({
    required String groupChatId,
    required String memberId,
  }) async {
    final url = GroupUrl.addMember;
    final token = await UserSecureStorage.fetchToken();
    var body = {"groupChatId": groupChatId, "memberId": memberId};
    var headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    final response = await ApiManager.putRequest(body, url, headers: headers);
    print(response.statusCode);

    var resBody = jsonDecode(response.body);
    if (resBody['success'] && resBody['status'] == 200) {
      return ApiResponse.fromJson(resBody, (data) => null);
    } else {
      throw Exception(resBody['message']);
    }
  }
}
