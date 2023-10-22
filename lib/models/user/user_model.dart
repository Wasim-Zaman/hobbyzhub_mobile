class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? birthdate;
  String? gender;
  String? pushToken;
  String? profilePicB64;

  UserModel(
      {this.userId,
      this.firstName,
      this.lastName,
      this.birthdate,
      this.gender,
      this.pushToken,
      this.profilePicB64});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    pushToken = json['pushToken'];
    profilePicB64 = json['profilePicB64'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['birthdate'] = birthdate;
    data['gender'] = gender;
    data['pushToken'] = pushToken;
    data['profilePicB64'] = profilePicB64;
    return data;
  }
}
