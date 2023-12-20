import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class CategoryController {
  static Future<ApiResponse> getAllCategories(int page, int pageSize) async {
    final token = await UserSecureStorage.fetchToken();
    const url = MainCategoryUrl.getAllCategories;
    final body = {"page": page, "size": pageSize};
    final headers = {"Authorization", "Bearer $token"};
    try {
      final response =
          await ApiManager.postRequest(url, body, headers: headers);
      var responseBody = jsonDecode(response.body);
      print(responseBody.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<CategoryModel> categories = [];
        responseBody['data'].forEach((category) {
          categories.add(CategoryModel.fromJson(category));
        });
        return ApiResponse.fromJson(responseBody, (data) => categories);
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
