import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:http/http.dart' as http;

class PostController {
  createPost(List<File> files) async {
    var request = http.MultipartRequest('POST', Uri.parse(PostUrl.createPost));

    // Add files to the request
    for (var file in files) {
      var length = await file.length();
      var multipartFile = http.MultipartFile('files', file.openRead(), length,
          filename: file.path.split('/').last);

      request.files.add(multipartFile);
    }

    // Add text in string to the request
    request.fields['userId'] = "hashdhad";

    // Add text in map to the request
    // request.fields['createPost'] = jsonEncode("First her");
    // print(request.fields['createPost']);

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Multipart request sent successfully');
      } else {
        print(
            'Failed to send multipart request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending multipart request: $error');
    }
  }
}
