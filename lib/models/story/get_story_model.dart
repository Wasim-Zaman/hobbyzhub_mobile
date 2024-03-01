// To parse this JSON data, do
//
//     final getStoriesModel = getStoriesModelFromJson(jsonString);

import 'dart:convert';

List<GetStoriesModel> getStoriesModelFromJson(String str) =>
    List<GetStoriesModel>.from(
        json.decode(str).map((x) => GetStoriesModel.fromJson(x)));

String getStoriesModelToJson(List<GetStoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetStoriesModel {
  List<String> storyImages;
  String storyCaption;
  String username;
  DateTime creationTime;

  GetStoriesModel({
    required this.storyImages,
    required this.storyCaption,
    required this.username,
    required this.creationTime,
  });

  factory GetStoriesModel.fromJson(Map<String, dynamic> json) =>
      GetStoriesModel(
        storyImages: List<String>.from(json["storyImages"].map((x) => x)),
        storyCaption: json["storyCaption"],
        username: json["username"],
        creationTime: DateTime.parse(json["creationTime"]),
      );

  Map<String, dynamic> toJson() => {
        "storyImages": List<dynamic>.from(storyImages.map((x) => x)),
        "storyCaption": storyCaption,
        "username": username,
        "creationTime": creationTime.toIso8601String(),
      };
}
