// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  String apiVersion;
  String organizationName;
  String message;
  bool success;
  int status;
  Data data;

  UserProfileModel({
    required this.apiVersion,
    required this.organizationName,
    required this.message,
    required this.success,
    required this.status,
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        apiVersion: json["apiVersion"],
        organizationName: json["organizationName"],
        message: json["message"],
        success: json["success"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "organizationName": organizationName,
        "message": message,
        "success": success,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  String email;
  String userId;
  String fullName;
  String gender;
  String bio;
  String profileImage;
  String joinedDate;
  String birthdate;

  Data({
    required this.email,
    required this.userId,
    required this.fullName,
    required this.gender,
    required this.bio,
    required this.profileImage,
    required this.joinedDate,
    required this.birthdate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        userId: json["userId"],
        fullName: json["fullName"],
        gender: json["gender"] ?? '',
        bio: json["bio"],
        profileImage: json["profileImage"],
        joinedDate: json["joinedDate"],
        birthdate: json["birthdate"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "userId": userId,
        "fullName": fullName,
        "gender": gender,
        "bio": bio,
        "profileImage": profileImage,
        "joinedDate": joinedDate,
        "birthdate": birthdate,
      };
}
