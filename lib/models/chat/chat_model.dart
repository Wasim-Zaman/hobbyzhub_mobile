class ChatModel {
  String? chatId;
  String? type;
  String? dateTimeCreated;
  ChatParticipantB? chatParticipantB;

  ChatModel(
      {this.chatId, this.type, this.dateTimeCreated, this.chatParticipantB});

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    type = json['type'];
    dateTimeCreated = json['dateTimeCreated'];
    chatParticipantB = json['chatParticipantB'] != null
        ? ChatParticipantB.fromJson(json['chatParticipantB'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['type'] = type;
    data['dateTimeCreated'] = dateTimeCreated;
    if (chatParticipantB != null) {
      data['chatParticipantB'] = chatParticipantB!.toJson();
    }
    return data;
  }
}

class ChatParticipantB {
  String? email;
  String? userId;
  String? fullName;
  String? gender;
  String? bio;
  String? profileImage;
  bool? categoryStatus;
  String? joinedDate;
  String? birthdate;

  ChatParticipantB(
      {this.email,
      this.userId,
      this.fullName,
      this.gender,
      this.bio,
      this.profileImage,
      this.categoryStatus,
      this.joinedDate,
      this.birthdate});

  ChatParticipantB.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['userId'];
    fullName = json['fullName'];
    gender = json['gender'];
    bio = json['bio'];
    profileImage = json['profileImage'];
    categoryStatus = json['categoryStatus'];
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
    data['categoryStatus'] = categoryStatus;
    data['joinedDate'] = joinedDate;
    data['birthdate'] = birthdate;
    return data;
  }
}
