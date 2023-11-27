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
}
