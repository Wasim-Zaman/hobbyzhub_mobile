// To parse this JSON data, do
//
//     final specificPostModel = specificPostModelFromJson(jsonString);

import 'dart:convert';

SpecificPostModel specificPostModelFromJson(String str) =>
    SpecificPostModel.fromJson(json.decode(str));

String specificPostModelToJson(SpecificPostModel data) =>
    json.encode(data.toJson());

class SpecificPostModel {
  String apiVersion;
  String organizationName;
  String message;
  Data data;

  SpecificPostModel({
    required this.apiVersion,
    required this.organizationName,
    required this.message,
    required this.data,
  });

  factory SpecificPostModel.fromJson(Map<String, dynamic> json) =>
      SpecificPostModel(
        apiVersion: json["apiVersion"],
        organizationName: json["organizationName"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "organizationName": organizationName,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String postId;
  String userId;
  String caption;
  List<String> imageUrls;
  DateTime postTime;
  List<dynamic> likes;
  List<Comment> comments;
  bool status;
  String username;
  dynamic profileImage;

  Data({
    required this.postId,
    required this.userId,
    required this.caption,
    required this.imageUrls,
    required this.postTime,
    required this.likes,
    required this.comments,
    required this.status,
    required this.username,
    required this.profileImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        postId: json["postId"],
        userId: json["userId"],
        caption: json["caption"],
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        postTime: DateTime.parse(json["postTime"]),
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        status: json["status"],
        username: json["username"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "userId": userId,
        "caption": caption,
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "postTime": postTime.toIso8601String(),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "status": status,
        "username": username,
        "profileImage": profileImage,
      };
}

class Comment {
  String commentId;
  int commentCount;
  String message;
  dynamic like;
  String username;
  dynamic profileImage;

  Comment({
    required this.commentId,
    required this.commentCount,
    required this.message,
    required this.like,
    required this.username,
    required this.profileImage,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["commentId"],
        commentCount: json["commentCount"],
        message: json["message"],
        like: json["like"],
        username: json["username"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentCount": commentCount,
        "message": message,
        "like": like,
        "username": username,
        "profileImage": profileImage,
      };
}
