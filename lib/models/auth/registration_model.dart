class AuthModel {
  String? apiVersion;
  String? organizationName;
  String? message;
  int? responseCode;
  Data? data;

  AuthModel(
      {this.apiVersion,
      this.organizationName,
      this.message,
      this.responseCode,
      this.data});

  AuthModel.fromJson(Map<String, dynamic> json) {
    apiVersion = json['apiVersion'];
    organizationName = json['organizationName'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['apiVersion'] = apiVersion;
    data['organizationName'] = organizationName;
    data['message'] = message;
    data['responseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;

  Data({this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    return data;
  }
}
