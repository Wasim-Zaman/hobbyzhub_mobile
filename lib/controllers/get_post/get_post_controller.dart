// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class GetPostController {
  getPosts() async {
    var url = PostUrl.getPost;
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await ApiManager.getRequest(url, headers: headers);

      return response;
    } catch (_) {
      rethrow;
    }
  }

  deletePosts(postId) async {
    var url = PostUrl.deletepost + "$postId";
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await ApiManager.deleteRequest(url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  specficPosts(postId) async {
    var url = PostUrl.specficPost + "$postId";
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      final response = await ApiManager.getRequest(url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
