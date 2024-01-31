class ChatModel {
  String? chatId;
  String? type;
  String? dateTimeCreated;
  List<ChatParticipants>? chatParticipants;

  ChatModel(
      {this.chatId, this.type, this.dateTimeCreated, this.chatParticipants});

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    type = json['type'];
    dateTimeCreated = json['dateTimeCreated'];
    if (json['chatParticipants'] != null) {
      chatParticipants = <ChatParticipants>[];
      json['chatParticipants'].forEach((v) {
        chatParticipants!.add(new ChatParticipants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['type'] = this.type;
    data['dateTimeCreated'] = this.dateTimeCreated;
    if (this.chatParticipants != null) {
      data['chatParticipants'] =
          this.chatParticipants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatParticipants {
  String? email;
  String? userId;
  String? fullName;
  String? gender;
  String? bio;
  String? profileImage;
  String? joinedDate;
  String? birthdate;

  ChatParticipants(
      {this.email,
      this.userId,
      this.fullName,
      this.gender,
      this.bio,
      this.profileImage,
      this.joinedDate,
      this.birthdate});

  ChatParticipants.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['userId'] = this.userId;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['bio'] = this.bio;
    data['profileImage'] = this.profileImage;
    data['joinedDate'] = this.joinedDate;
    data['birthdate'] = this.birthdate;
    return data;
  }
}
