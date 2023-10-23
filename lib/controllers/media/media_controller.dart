import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/upload_media/upload_pp_model.dart';
import 'package:http/http.dart';

class MediaController {
  //ApiResponse<UploadPPModel>
  static Future<ApiResponse<UploadPPModel>> uploadUserProfilePic(
    String userId,
    File file,
  ) async {
    // multi part request
    var request = MultipartRequest(
      'POST',
      Uri.parse("${MediaUrl.uploadProfilePicture}/$userId"),
    );

    // send the file as a part of the request
    request.files.add(
      MultipartFile(
        'file',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: file.path.split('/').last,
      ),
    );

    // send request
    var response = await request.send();

    if (response.statusCode == 200) {
      // success
      ApiResponse<UploadPPModel> model = ApiResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()),
          (data) => UploadPPModel.fromJson(data));
      return model;
    } else {
      // error
      ApiResponse<UploadPPModel> model = ApiResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()),
          (data) => UploadPPModel.fromJson(data));
      return model;
    }
  }
}
