import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostController {
  createPost(List<File> files, caption, hashtags) async {
    final userId = await UserSecureStorage.fetchUserId();
    final url = Uri.parse(PostUrl.createPost + "/${userId}");

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
    print(token);

    List mapofHashtags = [];

    for (var i = 0; i < hashtags.length; i++) {
      mapofHashtags.add({"tagName": hashtags[i]});
    }

    print(mapofHashtags);

    // request.fields['userId'] = '60b90846a017';

    Map<String, dynamic> jsonBody = {
      'caption': '${caption}',
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
      "Authorization": token.toString(),
    };
    request.headers.addAll(headers);

    final response = await request.send();

    return response;
  }
}
