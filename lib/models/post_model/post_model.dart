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
  String postId;
  String caption;
  DateTime postTime;
  dynamic profileImage;
  bool status;
  String userId;
  String username;
  List<HashTag>? hashTags;
  List<String> imageUrls;
  List<Like> likes;
  List<Comment> comments;

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
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
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
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  String commentId;
  int commentCount;
  String message;
  dynamic like;
  String username;
  dynamic profileImage;
  DateTime commentTime;

  Comment({
    required this.commentId,
    required this.commentCount,
    required this.message,
    required this.like,
    required this.username,
    required this.profileImage,
    required this.commentTime,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["commentId"],
        commentCount: json["commentCount"],
        message: json["message"],
        like: json["like"],
        username: json["username"],
        profileImage: json["profileImage"],
        commentTime: DateTime.parse(json["commentTime"]),
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentCount": commentCount,
        "message": message,
        "like": like,
        "username": username,
        "profileImage": profileImage,
        "commentTime": commentTime.toIso8601String(),
      };
}

class Like {
  String likeId;
  String username;
  int likeCount;
  dynamic profileImage;
  dynamic likeTime;

  Like({
    required this.likeId,
    required this.username,
    required this.likeCount,
    required this.profileImage,
    required this.likeTime,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        likeId: json["likeId"],
        username: json["username"],
        likeCount: json["likeCount"],
        profileImage: json["profileImage"],
        likeTime: json["likeTime"],
      );

  Map<String, dynamic> toJson() => {
        "likeId": likeId,
        "username": username,
        "likeCount": likeCount,
        "profileImage": profileImage,
        "likeTime": likeTime,
      };
}
