import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/models/category/sub_category_model.dart';

class CategoryController {
  static Future<ApiResponse> getMainCategories(int page, int pageSize) async {
    const url = MainCategoryUrl.getMainCategories;
    final body = {"page": page, "size": pageSize};
    try {
      final response = await ApiManager.postRequest(
        body,
        url,
        authorizationHeaders: true,
      );
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
    const url = MainCategoryUrl.getSubCategories;
    final body = {"categoryId": categoryId};
    try {
      final response = await ApiManager.postRequest(
        body,
        url,
        authorizationHeaders: true,
      );
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
    String subCategoryId,
    FinishAccountModel finishAccountModel,
  ) async {
    const url = MainCategoryUrl.subscribeUserToSubCategory;
    final body = {
      "userId": finishAccountModel.userId,
      "userName": finishAccountModel.fullName,
      "subCategoryId": subCategoryId,
      "profilePicLink": finishAccountModel.profileImage,
    };

    try {
      final response = await ApiManager.postRequest(
        body,
        url,
        authorizationHeaders: true,
      );
      var responseBody = jsonDecode(response.body);
      if (responseBody['success'] && responseBody['status'] == 200) {
        return ApiResponse.fromJson(responseBody, (data) => null);
      } else {
        throw Exception(responseBody['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
