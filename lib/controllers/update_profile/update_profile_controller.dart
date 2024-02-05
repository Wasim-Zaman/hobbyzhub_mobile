import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart';

class UpdateProfileController {
  completeProfile(image, userName, bio, dob) async {
    final url = AuthUrl.completeProfile;
    try {
      var userToken = await UserSecureStorage.fetchToken();
      var userId = await UserSecureStorage.fetchUserId();

      var request = MultipartRequest('PUT', Uri.parse(url));
      log(userToken.toString());
      log(userId.toString());

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

      request.fields["fullName"] = userName;
      request.fields["birthdate"] = dob;

      request.fields["bio"] = bio;

      // send request
      var response = await request.send();
      // print response
      var body = jsonDecode(await response.stream.bytesToString());
      print(body);
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
