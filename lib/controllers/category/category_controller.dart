import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/models/category/sub_category_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class CategoryController {
  static Future<ApiResponse> getMainCategories(int page, int pageSize) async {
    final token = await UserSecureStorage.fetchToken();
    const url = MainCategoryUrl.getMainCategories;
    final body = {"page": page, "size": pageSize};
    final headers = <String, String>{
      "Authorization":
          "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtdW5pckBnbWFpbC5jb20iLCJleHAiOjE3MDUzODA5OTIsImlhdCI6MTcwMjk2MTc5Mn0.ocdMEMo37yATycVlTXdWh9pzTiilcB_32mZJw6T9RDNJ9NS7rCAb-Tor6mXJmileGj0RDYsEBH7ZXZc1-Cws7A",
      "Content-Type": "application/json",
    };
    try {
      final response =
          await ApiManager.postRequest(body, url, headers: headers);
      var responseBody = jsonDecode(response.body);
      if (responseBody['success'] && responseBody['status'] == 200) {
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

  // Sub categories
  static Future<ApiResponse> getSubCategories(String categoryId) async {
    final token = await UserSecureStorage.fetchToken();
    const url = MainCategoryUrl.getSubCategories;
    final body = {"categoryId": categoryId};
    final headers = <String, String>{
      "Authorization":
          "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtdW5pckBnbWFpbC5jb20iLCJleHAiOjE3MDUzODA5OTIsImlhdCI6MTcwMjk2MTc5Mn0.ocdMEMo37yATycVlTXdWh9pzTiilcB_32mZJw6T9RDNJ9NS7rCAb-Tor6mXJmileGj0RDYsEBH7ZXZc1-Cws7A",
      "Content-Type": "application/json",
    };
    try {
      final response =
          await ApiManager.postRequest(body, url, headers: headers);
      var responseBody = jsonDecode(response.body);
      if (responseBody['success'] && responseBody['status'] == 200) {
        List<SubCategoryModel> subCategories = [];
        responseBody['data'].forEach((sc) {
          subCategories.add(SubCategoryModel.fromJson(sc));
        });
        return ApiResponse.fromJson(responseBody, (data) => subCategories);
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  // subscribe user to a sub category
  static Future<ApiResponse> subscribeUserToSubCategory(
      String subCategoryId) async {
    final userId = await UserSecureStorage.fetchUserId();
    const url = MainCategoryUrl.subscribeUserToSubCategory;
    final body = {
      "userId": userId,
      "userName": "",
      "subCategoryId": subCategoryId,
      "profilePicLink": null,
    };

    try {
      final response = await ApiManager.postRequest(body, url);
      var responseBody = jsonDecode(response.body);
      if (responseBody['success'] && responseBody['status'] == 200) {
        List<SubCategoryModel> subCategories = [];
        responseBody['data'].forEach((sc) {
          subCategories.add(SubCategoryModel.fromJson(sc));
        });
        return ApiResponse.fromJson(responseBody, (data) => subCategories);
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
