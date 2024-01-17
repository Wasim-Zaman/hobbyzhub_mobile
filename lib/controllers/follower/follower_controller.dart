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

  static Future<ApiResponse> getMyFollowings() async {
    const url = FollowersUrl.getMyFollowers;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"fromUserId": userId};
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

  static Future<ApiResponse> followUnfollow(
      {required String otherUserId}) async {
    const url = FollowersUrl.followUnfollow;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"myUserId": userId, "otherUserId": otherUserId};
    var headers = {
      "Authorization": "$token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    // print(responseBody);
    if (responseBody['success'] == true) {
      return ApiResponse.fromJson(responseBody, (data) => null);
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<Map> checkFollowing(String otherUserId) async {
    const url = FollowersUrl.checkFollowing;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"fromUserId": "cbaccfe0ae2d", "toUserId": "8ab64ae1df63"};
    var headers = {
      "Authorization": "$token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    if (responseBody['success'] == true) {
      return responseBody['data'];
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
