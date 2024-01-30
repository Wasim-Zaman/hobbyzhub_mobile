import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class UserController {
  getUserProfile(userId) async {
    final url = UserProfileUrl.userProfileUrl;
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
}
