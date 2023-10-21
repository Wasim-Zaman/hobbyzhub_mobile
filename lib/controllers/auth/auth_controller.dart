import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/auth/registration_model.dart';

abstract class AuthController {
  static Future<RegistrationModel> register(
      String email, String password) async {
    const url = AuthUrl.register;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegistrationModel.fromJson(jsonDecode(response.body));
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> login(String email, String password);
}
