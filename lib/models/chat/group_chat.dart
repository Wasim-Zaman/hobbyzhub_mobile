import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChat {
  String? room;
  String? groupImage;
  Map? lastMessage;
  List<String>? participantIds;
  List<Participants>? participants;
  Timestamp? timeStamp;
  String? title;
  String? type;
  List<String>? adminIds;
  Map? unread;
  String? groupDescription;

  GroupChat({
    this.room,
    this.groupImage,
    this.lastMessage,
    this.participantIds,
    this.participants,
    this.timeStamp,
    this.title,
    this.type,
    this.adminIds,
    this.unread,
    this.groupDescription,
  });

  GroupChat.fromJson(Map<String, dynamic> json) {
    room = json['room'];
    groupImage = json['groupImage'];
    lastMessage = json['lastMessage'];
    participantIds = json['participantIds'].cast<String>();
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {});
    }
    timeStamp = json['timeStamp'];
    title = json['title'];
    type = json['type'];
    adminIds = json['adminIds'].cast<String>();
    unread = json['unread'];
    groupDescription = json['groupDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room'] = room;
    data['groupImage'] = groupImage;
    data['lastMessage'] = lastMessage;
    data['participantIds'] = participantIds;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    data['timeStamp'] = timeStamp;
    data['title'] = title;
    data['type'] = type;
    data['adminIds'] = adminIds;
    data['unread'] = unread;
    data['groupDescription'] = groupDescription;
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
