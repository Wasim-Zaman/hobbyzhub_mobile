import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/auth/auth_model.dart';
import 'package:hobbyzhub/models/user/user_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

abstract class AuthController {
  static Future<AuthModel> _getResponse(var response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      return AuthModel.fromJson(body);
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data["message"]);
    }
  }

  static Future<AuthModel> register(String email, String password) async {
    const url = AuthUrl.register;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);

      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> sendVerificaionMail(String email) async {
    final url = "${AuthUrl.sendVerificationEmail}/$email";

    try {
      final response = await ApiManager.bodyLessPost(url, headers: {
        "Intent": "Verify-Email",
      });

      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> verifyOtp(String email, String otp) async {
    final url = "${AuthUrl.verifyOtp}/$email/$otp";

    try {
      final response = await ApiManager.bodyLessPut(url);

      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> verifyAccount(String email) async {
    final url = "${AuthUrl.verifyEmail}/$email";

    try {
      final response = await ApiManager.bodyLessPut(url);
      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> completeProfile({
    required UserModel user,
    required String token,
  }) async {
    const url = AuthUrl.completeProfile;
    try {
      final response = await ApiManager.putRequest(
        user.toJson(),
        url,
        headers: {"Authorization": token},
      );
      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> login(String email, String password) async {
    const url = AuthUrl.login;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);

      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<AuthModel> sendVerificaionMailForPasswordChange(
    String email,
    int otp,
  ) async {
    // get the token from local database
    final token = await UserSecureStorage.fetchToken();
    final url = "${AuthUrl.sendVerificationMailForPasswordReset}/$email/$otp";
    final response =
        await ApiManager.bodyLessPost(url, headers: <String, String>{
      "Authorization": token!,
      "Intent": "Reset-Password",
      "Content-Type": "application/json"
    });
    return _getResponse(response);
  }

  static Future<AuthModel> changePassword(
    String userId,
    String password,
  ) async {
    const url = AuthUrl.changePassword;
    // get the token from local database
    final token = await UserSecureStorage.fetchToken();

    try {
      final response = await ApiManager.putRequest(
          {"userId": userId, "password": password}, url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": token,
          });

      return _getResponse(response);
    } catch (_) {
      rethrow;
    }
  }
}
