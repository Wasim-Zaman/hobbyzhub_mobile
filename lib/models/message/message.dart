import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? messageId;
  String? mediaType;
  String? mediaUrl;
  String? message;
  Metadata? metadata;
  String? room;
  Timestamp? timeStamp;
  bool? unread;
  int? messageCounter;

  Message({
    this.messageId,
    this.mediaType,
    this.mediaUrl,
    this.message,
    this.metadata,
    this.room,
    this.timeStamp,
    this.unread,
    this.messageCounter,
  });

  Message.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    mediaType = json['mediaType'];
    mediaUrl = json['mediaUrl'];
    message = json['message'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    room = json['room'];
    timeStamp =
        json['timeStamp'] is Timestamp ? json['timeStamp'] as Timestamp : null;
    unread = json['unread'];
    messageCounter = json['messageCounter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageId'] = messageId;
    data['mediaType'] = mediaType;
    data['mediaUrl'] = mediaUrl;
    data['message'] = message;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    data['room'] = room;
    data['timeStamp'] = timeStamp;
    data['unread'] = unread;
    data['messageCounter'] = messageCounter;
    return data;
  }
}

class Metadata {
  String? metadataId;
  String? sender;
  String? receiver;
  String? room;
  Timestamp? timeStamp;

  Metadata(
      {this.metadataId, this.sender, this.receiver, this.room, this.timeStamp});

  Metadata.fromJson(Map<String, dynamic> json) {
    metadataId = json['metadataId'];
    sender = json['sender'];
    receiver = json['receiver'];
    room = json['room'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['metadataId'] = metadataId;
    data['sender'] = sender;
    data['receiver'] = receiver;
    data['room'] = room;
    data['timeStamp'] = timeStamp;
    return data;
  }
}
