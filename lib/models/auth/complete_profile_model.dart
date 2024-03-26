import 'dart:io';

class CompleteProfileModel {
  String? name, bio, userId, token, birthDate, gender;
  File? profilePicture;

  CompleteProfileModel({
    this.name,
    this.bio,
    this.userId,
    this.token,
    this.birthDate,
    this.gender,
    this.profilePicture,
  });

  CompleteProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    userId = json['userId'];
    token = json['token'];
    birthDate = json['birthDate'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['bio'] = bio;
    data['userId'] = userId;
    data['token'] = token;
    data['birthDate'] = birthDate;
    data['gender'] = gender;
    return data;
  }
}
