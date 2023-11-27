class LoginModel {
  String? token;
  String? userId;
  String? email;
  bool? newAccount;

  LoginModel({this.token, this.userId, this.email, this.newAccount});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    email = json['email'];
    newAccount = json['newAccount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userId'] = userId;
    data['email'] = email;
    data['newAccount'] = newAccount;
    return data;
  }
}
