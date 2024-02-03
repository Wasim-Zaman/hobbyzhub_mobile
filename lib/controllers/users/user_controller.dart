import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class UserController {
  getUserProfile(userId) async {
    final url = UserProfileUrl.userProfileUrl;
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response =
          await ApiManager.postRequest(userId, url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  getUserPost(userId) async {
    final url = UserProfileUrl.userPostsUrl;
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      final response =
          await ApiManager.postRequest(userId, url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> searchUsersByName({
    required String slug,
    int page = 0,
    int pageSize = 20,
  }) async {
    final token = await UserSecureStorage.fetchToken();
    final url = AuthUrl.searchUserByName;
    final body = {"searchSlug": slug, "page": page, "size": pageSize};
    final headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    final response = await ApiManager.postRequest(body, url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] == true) {
      final List<User> users = [];
      responseBody['data'].forEach((user) {
        users.add(User.fromJson(user));
      });
      return ApiResponse.fromJson(responseBody, (p0) => users);
    } else {
      throw Exception(responseBody['message']);
    }
  }
}
