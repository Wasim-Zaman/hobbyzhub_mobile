import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostController {
  createPost(List<File> files, caption, hashtags) async {
    final userId = await UserSecureStorage.fetchUserId();
    final url = Uri.parse("${PostUrl.createPost}/$userId");

    log(url.toString());

    final request = http.MultipartRequest('POST', url);

    List<String> filePaths = [];

    for (var i = 0; i < files.length; i++) {
      filePaths.add(files[i].path);
    }
    for (String filePath in filePaths) {
      String fileName = filePath.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'files',
          filePath,
          filename: fileName,
        ),
      );
    }

    final token = await UserSecureStorage.fetchToken();

    List mapofHashtags = [];

    for (var i = 0; i < hashtags.length; i++) {
      mapofHashtags.add({"tagName": hashtags[i]});
    }

    // request.fields['userId'] = '60b90846a017';

    Map<String, dynamic> jsonBody = {
      'caption': '$caption',
      'hashTags': mapofHashtags
    };
    request.files.add(
      http.MultipartFile.fromString(
        'createPost',
        json.encode(jsonBody),
        contentType: MediaType('application', 'json'),
      ),
    );
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
    };
    request.headers.addAll(headers);

    final response = await request.send();

    return response;
  }

  writeCommentFunction(postId, comment) async {
    try {
      final token = await UserSecureStorage.fetchToken();
      final url = "${PostUrl.createComment}?postId=$postId";

      final headers = <String, String>{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };

      final body = {"message": comment};

      final response =
          await ApiManager.postRequest(body, url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  createLikeFunction(postId) async {
    try {
      final token = await UserSecureStorage.fetchToken();
      final userId = await UserSecureStorage.fetchUserId();
      print(userId);

      final url = "${PostUrl.createLike}?postId=$postId&likerUserId=$userId";

      final headers = <String, String>{
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };

      final response =
          await ApiManager.postRequestWithoutBody(url, headers: headers);
      return response;
    } catch (_) {
      rethrow;
    }
  }

  createuNLikeFunction(likeId) async {
    try {
      final token = await UserSecureStorage.fetchToken();

      final url = "${PostUrl.createUnLike}?likeId=$likeId";

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
}
