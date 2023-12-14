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
  String? caption;
  DateTime postTime;
  bool status;
  String username;
  dynamic profileImage;
  List<HashTag>? hashTags;
  List<dynamic> comments;
  List<dynamic> likes;
  List<String> imageUrls;
  String? postId;
  String? userId;

  Datum({
    required this.caption,
    required this.postTime,
    required this.status,
    required this.username,
    required this.profileImage,
    this.hashTags,
    required this.comments,
    required this.likes,
    required this.imageUrls,
    this.postId,
    this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        caption: json["caption"],
        postTime: DateTime.parse(json["postTime"]),
        status: json["status"],
        username: json["username"] ?? '',
        profileImage: json["profileImage"],
        hashTags: json["hashTags"] == null
            ? []
            : List<HashTag>.from(
                json["hashTags"]!.map((x) => HashTag.fromJson(x))),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        postId: json["postId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "caption": caption,
        "postTime": postTime.toIso8601String(),
        "status": status,
        "username": username,
        "profileImage": profileImage,
        "hashTags": hashTags == null
            ? []
            : List<dynamic>.from(hashTags!.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "postId": postId,
        "userId": userId,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
