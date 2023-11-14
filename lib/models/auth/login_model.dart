class LoginModel {
  String? userId;
  String? accessToken;
  String? userName;
  Null? userProfilePicLink;
  String? userEmail;
  bool? newUser;
  int? tokenExpirationMS;
  String? tokenExpiresAt;

  LoginModel(
      {this.userId,
      this.accessToken,
      this.userName,
      this.userProfilePicLink,
      this.userEmail,
      this.newUser,
      this.tokenExpirationMS,
      this.tokenExpiresAt});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    userName = json['userName'];
    userProfilePicLink = json['userProfilePicLink'];
    userEmail = json['userEmail'];
    newUser = json['newUser'];
    tokenExpirationMS = json['tokenExpirationMS'];
    tokenExpiresAt = json['tokenExpiresAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['accessToken'] = accessToken;
    data['userName'] = userName;
    data['userProfilePicLink'] = userProfilePicLink;
    data['userEmail'] = userEmail;
    data['newUser'] = newUser;
    data['tokenExpirationMS'] = tokenExpirationMS;
    data['tokenExpiresAt'] = tokenExpiresAt;
    return data;
  }
}
