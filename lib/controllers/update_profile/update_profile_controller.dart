import 'dart:convert';
import 'dart:developer';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart';

class UpdateProfileController {
  completeProfile(image, userName, bio, dob, gender) async {
    try {
      var userToken = await UserSecureStorage.fetchToken();
      var userId = await UserSecureStorage.fetchUserId();

      final url =
          "${AuthUrl.completeProfile}?userId=$userId&fullName=$userName&birthdate=$dob&gender=$gender&bio=$bio";

      var request = MultipartRequest('PUT', Uri.parse(url));

      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer $userToken",
      });

      if (image != null) {
        request.files.add(
          MultipartFile(
            'profileImage',
            image.readAsBytes().asStream(),
            image.lengthSync(),
            filename: image.path.split('/').last,
          ),
        );
      }

      // send request
      var response = await request.send();

      var body = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        // success

        return response;
      } else {
        throw Exception(body['message']);
      }
    } catch (_) {
      rethrow;
    }
  }
}
