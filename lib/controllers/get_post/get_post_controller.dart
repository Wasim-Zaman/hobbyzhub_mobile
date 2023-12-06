import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class GetPostController {
  getPosts() async {
    const url = PostUrl.getPost;
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      final response = await ApiManager.getRequest(url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
