// To parse this JSON data, do
//
//     final userPostModel = userPostModelFromJson(jsonString);

import 'dart:convert';

UserPostModel userPostModelFromJson(String str) =>
    UserPostModel.fromJson(json.decode(str));

String userPostModelToJson(UserPostModel data) => json.encode(data.toJson());

class UserPostModel {
  String apiVersion;
  String organizationName;
  String message;
  List<Datum> data;

  UserPostModel({
    required this.apiVersion,
    required this.organizationName,
    required this.message,
    required this.data,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
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

class HashTag {
  String hashTagId;
  String tagName;
  List<Datum> posts;

  HashTag({
    required this.hashTagId,
    required this.tagName,
    required this.posts,
  });

  factory HashTag.fromJson(Map<String, dynamic> json) => HashTag(
        hashTagId: json["hashTagId"],
        tagName: json["tagName"],
        posts: List<Datum>.from(json["posts"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hashTagId": hashTagId,
        "tagName": tagName,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Datum {
  String postId;
  String caption;
  DateTime postTime;
  String profileImage;
  bool status;
  String userId;
  String username;
  List<HashTag>? hashTags;
  List<String> imageUrls;
  List<Like> likes;
  List<dynamic> comments;
  int? likeCount;
  bool? deActivateComments;

  Datum({
    required this.postId,
    required this.caption,
    required this.postTime,
    required this.profileImage,
    required this.status,
    required this.userId,
    required this.username,
    this.hashTags,
    required this.imageUrls,
    required this.likes,
    required this.comments,
    this.likeCount,
    this.deActivateComments,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        postId: json["postId"],
        caption: json["caption"],
        postTime: DateTime.parse(json["postTime"]),
        profileImage: json["profileImage"],
        status: json["status"],
        userId: json["userId"],
        username: json["username"],
        hashTags: json["hashTags"] == null
            ? []
            : List<HashTag>.from(
                json["hashTags"]!.map((x) => HashTag.fromJson(x))),
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likeCount: json["likeCount"],
        deActivateComments: json["deActivateComments"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "caption": caption,
        "postTime": postTime.toIso8601String(),
        "profileImage": profileImage,
        "status": status,
        "userId": userId,
        "username": username,
        "hashTags": hashTags == null
            ? []
            : List<dynamic>.from(hashTags!.map((x) => x.toJson())),
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "likeCount": likeCount,
        "deActivateComments": deActivateComments,
      };
}

class Like {
  String likeId;
  String username;
  int likeCount;
  String profileImage;
  DateTime likeTime;
  String userId;

  Like({
    required this.likeId,
    required this.username,
    required this.likeCount,
    required this.profileImage,
    required this.likeTime,
    required this.userId,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        likeId: json["likeId"],
        username: json["username"],
        likeCount: json["likeCount"],
        profileImage: json["profileImage"],
        likeTime: DateTime.parse(json["likeTime"]),
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "likeId": likeId,
        "username": username,
        "likeCount": likeCount,
        "profileImage": profileImage,
        "likeTime": likeTime.toIso8601String(),
        "userId": userId,
      };
}
