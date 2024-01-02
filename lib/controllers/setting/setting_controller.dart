import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class SettingController {
  submitHelpCenterRequest(body) async {
    const url = SettingUrl.helpCenterUrl;
    try {
      final token = await UserSecureStorage.fetchToken();

      final headers = <String, String>{
        "Authorization": token.toString(),
        "Content-Type": "application/json"
      };
      final response =
          await ApiManager.postRequest(body, url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
