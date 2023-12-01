import 'dart:convert';
import 'dart:io';

import 'package:hobbyzhub/constants/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PostController {
  createPost(List<File> files) async {
    // Replace the URL with your server endpoint
    final url = Uri.parse(PostUrl.createPost);

    // Create a new multipart request
    final request = http.MultipartRequest('POST', url);

    // Add files to the request
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

    // Add query parameters
    request.fields['userId'] = 'hasdasdha';

    // Add JSON body
    Map<String, dynamic> jsonBody = {'caption': 'hello'};
    request.files.add(
      http.MultipartFile.fromString(
        'createPost',
        json.encode(jsonBody),
        contentType: MediaType('application', 'json'),
      ),
    );

    // Send the request
    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        print('Request successful');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }
}
