import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostController {
  createPost(List<File> files, caption) async {
    final url = Uri.parse(PostUrl.createPost);

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

    var userId = await UserSecureStorage.fetchUserId();

    request.fields['userId'] = '${userId}';

    Map<String, dynamic> jsonBody = {'caption': '${caption}'};
    request.files.add(
      http.MultipartFile.fromString(
        'createPost',
        json.encode(jsonBody),
        contentType: MediaType('application', 'json'),
      ),
    );

    final response = await request.send();

    return response;
  }
}
