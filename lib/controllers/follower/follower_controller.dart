import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/follower/follower_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class FollowerController {
  static Future<ApiResponse> getMyFollowers() async {
    const url = FollowersUrl.getMyFollowers;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"toUserId": userId};
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);

    if (responseBody['success'] == true && responseBody['status'] == 200) {
      List<FollowerModel> followers = [];
      responseBody['data'].forEach((follower) {
        followers.add(FollowerModel.fromJson(follower));
      });
      return ApiResponse.fromJson(responseBody, (data) => followers);
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
