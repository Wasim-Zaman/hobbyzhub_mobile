class FollowerModel {
  String? userId;
  String? fullName;
  String? profileImage;
  bool? following;

  FollowerModel(
      {this.userId, this.fullName, this.profileImage, this.following});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    profileImage = json['profileImage'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['fullName'] = fullName;
    data['profileImage'] = profileImage;
    data['following'] = following;
    return data;
  }
}
