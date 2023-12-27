import 'dart:convert';

import 'package:hobbyzhub/models/api_response.dart';
import 'package:http/http.dart';

class ApiManager {
  // Static method for making a GET request.
  static Future<Response> getRequest(var url, {dynamic headers}) async {
    // Perform a GET request and return the response.
    return await get(
      Uri.parse(url),
      headers: headers,
    );
  }

  // Static method for making a PUT request.
  static Future<Response> putRequest(var body, var url,
      {dynamic headers}) async {
    // Perform a PUT request with the specified body and return the response.
    return await put(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers ?? {'Content-Type': 'application/json'},
    );
  }

  // Static method for making a POST request.
  static Future<Response> postRequest(var body, var url,
      {dynamic headers}) async {
    // Perform a POST request with the specified body and return the response.
    return await post(Uri.parse(url),
        body: jsonEncode(body),
        headers: headers ?? {'Content-Type': 'application/json'});
  }

// Static method for making a POST request without body.
  static Future<Response> postRequestWithoutBody(var url,
      {dynamic headers}) async {
    // Perform a POST request with the specified body and return the response.
    return await post(Uri.parse(url),
        headers: headers ?? {'Content-Type': 'application/json'});
  }

  static Future<Response> deleteRequest(var url, {dynamic headers}) async {
    // Perform a GET request and return the response.
    return await delete(
      Uri.parse(url),
      headers: headers,
    );
  }

  static Future<ApiResponse> returnModel(var response, {var model}) async {
    final body = jsonDecode(response.body);
    if (body['success'] == true) {
      return ApiResponse.fromJson(body, (data) => model);
    } else {
      throw Exception(body['message']);
    }
  }
}
