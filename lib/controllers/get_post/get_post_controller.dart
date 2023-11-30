import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';

class GetPostController {
  getPosts() async {
    const url = PostUrl.getPost;
    try {
      final response = await ApiManager.getRequest(url);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
