import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/auth/complete_profile_model.dart';
import 'package:hobbyzhub/models/auth/login_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart';

abstract class AuthController {
  static Future<ApiResponse> _getResponseApi(var response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      var body = jsonDecode(response.body);
      if (body['success'] == true) {
        return ApiResponse.fromJson(body, (data) => null);
      } else {
        throw Exception(body['message']);
      }
    } else {
      final data = jsonDecode(response.body);
      throw Exception(data["message"]);
    }
  }

  static Future<ApiResponse> register(String email, String password) async {
    const url = AuthUrl.register;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);
      return _getResponseApi(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> sendSignupVerificationMail(String email) async {
    const url = AuthUrl.sendSignupVerificationEmail;
    try {
      final response = await ApiManager.postRequest({'email': email}, url);
      print(response.body);
      return _getResponseApi(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> verifyOtpForBoth(String email, String otp) async {
    const url = AuthUrl.verifyOtp;

    try {
      final response = await ApiManager.putRequest(
        {"email": email, "temporaryOtp": otp},
        url,
      );
      return _getResponseApi(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> verifyAccount(String email) async {
    const url = AuthUrl.activateAccount;

    try {
      final response = await ApiManager.putRequest({"email": email}, url);
      return _getResponseApi(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> completeProfile({
    required CompleteProfileModel model,
  }) async {
    const url = AuthUrl.completeProfile;
    try {
// multi part request
      var request = MultipartRequest(
        'PUT',
        Uri.parse(url),
      );

      request.headers.addAll({
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer ${model.token}",
      });

      if (model.profilePicture != null) {
        request.files.add(
          MultipartFile(
            'profileImage',
            model.profilePicture!.readAsBytes().asStream(),
            model.profilePicture!.lengthSync(),
            filename: model.profilePicture!.path.split('/').last,
          ),
        );
      }

      // send other fields
      request.fields["userId"] = "2b797185fb19";
      request.fields["fullName"] = model.name.toString();
      request.fields["birthdate"] = model.birthDate.toString();
      request.fields["gender"] = model.birthDate.toString();

      // send request
      var response = await request.send();
      // print response
      var body = jsonDecode(await response.stream.bytesToString());
      print(body);
      if (response.statusCode == 200) {
        // success
        ApiResponse model = ApiResponse.fromJson(
          body,
          (data) => null,
        );
        return model;
      } else {
        throw Exception(body['message']);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse<LoginModel>> login(
    String email,
    String password,
  ) async {
    const url = AuthUrl.login;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        ApiResponse<LoginModel> model = ApiResponse.fromJson(
          body,
          (data) => LoginModel.fromJson(body['data']),
        );
        return model;
      } else {
        final data = jsonDecode(response.body);
        throw Exception(data["message"]);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> sendVerificaionMailForPasswordChange(
    String email,
  ) async {
    // get the token from local database
    final token = await UserSecureStorage.fetchToken();
    const url = AuthUrl.sendVerificationMailForPasswordReset;
    final response = await ApiManager.postRequest({'email': email}, url,
        headers: <String, String>{
          "Authorization": token.toString(),
          "Intent": "Reset-Password",
          "Content-Type": "application/json"
        });
    return _getResponseApi(response);
  }

  static Future<ApiResponse> changePassword(
    String email,
    String password,
  ) async {
    const url = AuthUrl.changePassword;
    // get the token from local database
    final token = await UserSecureStorage.fetchToken();
    try {
      final response = await ApiManager.putRequest(
          {"email": email, "password": password}, url,
          headers: <String, String>{
            "Content-Type": "application/json",
            "Authorization": token.toString(),
          });
      return _getResponseApi(response);
    } catch (_) {
      rethrow;
    }
  }
}
