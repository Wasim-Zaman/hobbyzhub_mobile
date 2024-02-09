import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
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
    print(resBody);

    if (resBody['success'] && resBody['status'] == 200) {
      return ApiResponse.fromJson(resBody, (p0) => null);
    } else {
      throw Exception(resBody['message']);
    }
  }
}
