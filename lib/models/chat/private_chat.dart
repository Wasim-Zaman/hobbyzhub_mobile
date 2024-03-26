class PrivateChat {
  String? room;
  Map? lastMessage;
  List<String>? participantIds;
  List<Participants>? participants;
  Map? unread;
  String? timeStamp;
  String? type;

  PrivateChat(
      {this.room,
      this.lastMessage,
      this.participantIds,
      this.participants,
      this.unread,
      this.timeStamp,
      this.type});

  PrivateChat.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    lastMessage = json['lastMessage'];
    participantIds = json['participantIds'].cast<String>();
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
    unread = json['unread'];
    // timeStamp = json['timeStamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room'] = room;
    data['lastMessage'] = lastMessage;
    data['participantIds'] = participantIds;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['unread'] = unread;
    data['timeStamp'] = timeStamp;
    data['type'] = type;
    return data;
  }
}

class Participants {
  String? participantId;
  String? bio;
  String? email;
  String? fullName;
  String? gender;
  String? profileImage;
  String? userId;
  String? room;

  Participants(
      {this.participantId,
      this.bio,
      this.email,
      this.fullName,
      this.gender,
      this.profileImage,
      this.userId,
      this.room});

  Participants.fromJson(Map<String, dynamic> json) {
    participantId = json['participantId'];
    bio = json['bio'];
    email = json['email'];
    fullName = json['fullName'];
    gender = json['gender'];
    profileImage = json['profileImage'];
    userId = json['userId'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['participantId'] = participantId;
    data['bio'] = bio;
    data['email'] = email;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['profileImage'] = profileImage;
    data['userId'] = userId;
    data['room'] = room;
    return data;
  }
}
