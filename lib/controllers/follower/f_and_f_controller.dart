import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/follower/follower_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class FAndFController {
  static Future<ApiResponse> getMyFollowers() async {
    final url = FollowersUrl.getMyFollowers;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"otherUserId": userId, "page": 0, "size": 10};
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
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
    final url = FollowersUrl.getMyFollowings;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"myUserId": userId, "page": 0, "size": 10};
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    if (responseBody['success'] == true) {
      List<FollowerModel> followers = [];
      responseBody['data'].forEach((follower) {
        followers.add(FollowerModel.fromJson(follower));
      });
      return ApiResponse.fromJson(responseBody, (data) => followers);
    } else {
      throw Exception(responseBody['message']);
    }
  }

  // other person followers and followings
  static Future<ApiResponse> getOtherFollowers(String otherUserId) async {
    final url = FollowersUrl.getOtherFollowers;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {
      "otherUserId": otherUserId,
      "myUserId": userId,
      "page": 0,
      "size": 10,
    };
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      List<FollowerModel> followers = [];
      responseBody['data'].forEach((follower) {
        followers.add(FollowerModel.fromJson(follower));
      });
      return ApiResponse.fromJson(responseBody, (data) => followers);
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<ApiResponse> getOtherFollowings(String otherUserId) async {
    final url = FollowersUrl.getOtherFollowings;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {
      "otherUserId": otherUserId,
      "myUserId": userId,
      "page": 0,
      "size": 10
    };
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    print("other followings");
    if (responseBody['success'] == true) {
      List<FollowerModel> followers = [];
      responseBody['data'].forEach((follower) {
        followers.add(FollowerModel.fromJson(follower));
      });
      return ApiResponse.fromJson(responseBody, (data) => followers);
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<Map<String, dynamic>> getCount({String? uid}) async {
    final url = FollowersUrl.getCount;
    final userId = uid ?? await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"userID": userId};
    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      return responseBody['data'];
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<ApiResponse> followUnfollow(
      {required String otherUserId}) async {
    final url = FollowersUrl.followUnfollow;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"myUserId": userId, "otherUserId": otherUserId};
    var headers = {
      "Authorization": "$token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    if (responseBody['success'] == true) {
      return ApiResponse.fromJson(responseBody, (data) => null);
    } else {
      throw Exception(responseBody['message']);
    }
  }

  static Future<Map> checkFollowing(String otherUserId) async {
    final url = FollowersUrl.checkFollowing;
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();
    var body = {"myUserId": userId, "otherUserId": otherUserId};
    var headers = {
      "Authorization": "$token",
      "Content-Type": "application/json",
    };
    var response = await ApiManager.postRequest(body, url, headers: headers);
    var responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      return responseBody['data'];
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
