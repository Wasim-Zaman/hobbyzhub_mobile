import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/category/category_model.dart';

class CategoryController {
  static Future<ApiResponse> getAllCategories(int page, int pageSize) async {
    final url = "${CategoryUrl.getAllCategories}page=$page&size=$pageSize";
    try {
      final response = await ApiManager.getRequest(url);
      var responseBody = jsonDecode(response.body);
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
