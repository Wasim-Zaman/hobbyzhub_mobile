import 'dart:convert';

import 'package:hobbyzhub/constants/api_manager.dart';
import 'package:hobbyzhub/constants/app_url.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/auth/complete_profile_model.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
import 'package:hobbyzhub/models/auth/login_model.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:http/http.dart';

abstract class AuthController {
  static Future<ApiResponse> register(String email, String password) async {
    const url = AuthUrl.register;
    try {
      final response = await ApiManager.postRequest({
        'email': email,
        'password': password,
      }, url);
      return ApiManager.returnModel(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> sendSignupVerificationMail(String email) async {
    const url = AuthUrl.sendSignupVerificationEmail;
    try {
      final response = await ApiManager.postRequest({'email': email}, url);
      return ApiManager.returnModel(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> verifyOtpForBoth(String email, String otp) async {
    const url = AuthUrl.verifyOtp;
    final body = {"email": email, "temporaryOtp": otp};
    try {
      final response = await ApiManager.putRequest(body, url);
      return ApiManager.returnModel(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> verifyAccount(String email) async {
    const url = AuthUrl.activateAccount;

    try {
      final response = await ApiManager.putRequest({"email": email}, url);
      return ApiManager.returnModel(response);
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> completeProfile({
    required CompleteProfileModel model,
  }) async {
    const url = AuthUrl.completeProfile;
    try {
      var request = MultipartRequest('PUT', Uri.parse(url));

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
      // print(model.profilePicture!.path.split('/').last);
      // send other fields
      request.fields["userId"] = model.userId.toString();
      request.fields["fullName"] = model.name.toString();
      request.fields["birthdate"] = model.birthDate.toString();
      request.fields["gender"] = model.birthDate.toString();
      request.fields["bio"] = model.bio.toString();

      // send request
      var response = await request.send();
      // print response
      var body = jsonDecode(await response.stream.bytesToString());
      print(body);
      if (response.statusCode == 200) {
        // success
        ApiResponse model = ApiResponse.fromJson(
          body,
          (data) => FinishAccountModel.fromJson(body['data']),
        );
        return model;
      } else {
        throw Exception(body['message']);
      }
    } catch (_) {
      rethrow;
    }
  }

  static Future<ApiResponse> login(
    String email,
    String password,
  ) async {
    const url = AuthUrl.login;
    Map body = {'email': email, 'password': password};
    try {
      final response = await ApiManager.postRequest(body, url);
      final json = jsonDecode(response.body);
      return ApiManager.returnModel(
        response,
        model: json['data'] != null ? LoginModel.fromJson(json['data']) : null,
      );
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
    final body = {'email': email};
    final headers = <String, String>{
      "Authorization": token.toString(),
      "Intent": "Reset-Password",
      "Content-Type": "application/json"
    };
    final response = await ApiManager.postRequest(body, url, headers: headers);
    return ApiManager.returnModel(response);
  }

  static Future<ApiResponse> changePassword(
    String email,
    String password,
  ) async {
    const url = AuthUrl.changePassword;
    final body = {"email": email, "newPassword": password};

    final response = await ApiManager.putRequest(body, url);
    return ApiManager.returnModel(response);
  }
}
