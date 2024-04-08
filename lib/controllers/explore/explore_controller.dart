import 'dart:convert';
import 'dart:developer';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/models/post_model/post.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_exceptions.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class ExploreController {
  static Future<ApiResponse> getRandomPosts(int page, int size) async {
    final url = "${ExploreUrl.getRandomPosts}?page=$page&size=$size";
    final token = await UserSecureStorage.fetchToken();

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.getRequest(url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success']) {
      List<Post> posts = [];
      responseBody['data']['content'].forEach((post) {
        posts.add(Post.fromJson(post));
      });
      return ApiResponse.fromJson(responseBody, (p0) => posts);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> getRandomUsers(int page, int size) async {
    final url = "${ExploreUrl.getRandomUsers}?page=$page&size=$size";
    final token = await UserSecureStorage.fetchToken();

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.getRequest(url, headers: headers);

    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] && responseBody['status'] == 200) {
      List<User> users = [];
      responseBody['data']['content'].forEach((user) {
        users.add(User.fromJson(user));
      });
      return ApiResponse.fromJson(responseBody, (p0) => users);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> getSubscribedHobbyz(int page, int size) async {
    final userId = await UserSecureStorage.fetchUserId();
    final token = await UserSecureStorage.fetchToken();

    final url = "${ExploreUrl.getHobbyz}?page=$page&size=$size&userId=$userId";
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.getRequest(url, headers: headers);
    print(response.statusCode);
    log(response.body);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] && responseBody['status'] == 200) {
      List<CategoryModel> hobbyz = [];
      responseBody['data']['content'].forEach((hobby) {
        hobbyz.add(CategoryModel.fromJson(hobby));
      });
      return ApiResponse.fromJson(responseBody, (data) => hobbyz);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }

  static Future<ApiResponse> getHobbyPosts(
    String hobbyId,
    int page,
    int size,
  ) async {
    final token = await UserSecureStorage.fetchToken();
    final url =
        "${ExploreUrl.getPostsByHobby}?hobbyId=$hobbyId&page=$page&size=$size";
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await ApiManager.getRequest(url, headers: headers);
    final responseBody = jsonDecode(response.body);
    if (responseBody['success'] && responseBody['status'] == 200) {
      List<Post> posts = [];
      responseBody['data']['content'].forEach((post) {
        posts.add(Post.fromJson(post));
      });
      return ApiResponse.fromJson(responseBody, (p0) => posts);
    } else {
      throw ErrorException(responseBody['message']);
    }
  }
}
