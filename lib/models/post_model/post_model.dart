// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  String apiVersion;
  String organizationName;
  String message;
  List<Datum> data;

  PostModel({
    required this.apiVersion,
    required this.organizationName,
    required this.message,
    required this.data,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        apiVersion: json["apiVersion"],
        organizationName: json["organizationName"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "organizationName": organizationName,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String postId;
  String userId;
  String username;
  String profileImage;

  String caption;
  List<String> imageUrls;
  DateTime postTime;
  List<dynamic> likes;
  List<dynamic> comments;
  bool status;

  Datum({
    required this.postId,
    required this.userId,
    required this.username,
    required this.profileImage,
    required this.caption,
    required this.imageUrls,
    required this.postTime,
    required this.likes,
    required this.comments,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        postId: json["postId"],
        userId: json["userId"],
        caption: json["caption"],
        username: json["username"] ?? '',
        profileImage: json["profileImage"] ?? '',
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        postTime: DateTime.parse(json["postTime"]),
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userId": userId,
        "caption": caption,
        "profileImage": profileImage,
        "username": username,
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "postTime": postTime.toIso8601String(),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "status": status,
      };
}
