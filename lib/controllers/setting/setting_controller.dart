import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class SettingController {
  submitHelpCenterRequest(body) async {
    final userId = await UserSecureStorage.fetchUserId();
    var url = SettingUrl.helpCenterUrl + "/$userId";
    try {
      final response =
          await ApiManager.postRequest(body, url, authorizationHeaders: true);
      return response;
    } catch (_) {
      rethrow;
    }
  }
}
