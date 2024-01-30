class User {
  String? email;
  String? userId;
  String? fullName;
  String? gender;
  String? bio;
  String? profileImage;
  String? joinedDate;
  String? birthdate;

  User(
      {this.email,
      this.userId,
      this.fullName,
      this.gender,
      this.bio,
      this.profileImage,
      this.joinedDate,
      this.birthdate});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['userId'];
    fullName = json['fullName'];
    gender = json['gender'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    joinedDate = json['joinedDate'];
    birthdate = json['birthdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['bio'] = bio;
    data['profileImage'] = profileImage;
    data['joinedDate'] = joinedDate;
    data['birthdate'] = birthdate;
    return data;
  }
}
