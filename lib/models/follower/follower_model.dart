class FollowerModel {
  String? fullName;
  String? profileImage;
  bool? following;

  FollowerModel({this.fullName, this.profileImage, this.following});

  FollowerModel.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    profileImage = json['profileImage'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['profileImage'] = profileImage;
    data['following'] = following;
    return data;
  }
}
