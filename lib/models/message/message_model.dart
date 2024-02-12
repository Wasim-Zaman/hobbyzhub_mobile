import 'package:hive/hive.dart';

part 'message_model.g.dart'; // Name of the generated file

@HiveType(typeId: 0)
class MessageModel extends HiveObject {
  @HiveField(0)
  String? messageString;
  @HiveField(1)
  String? chatId;
  @HiveField(2)
  String? media;
  @HiveField(3)
  Metadata? metadata;

  MessageModel({this.messageString, this.chatId, this.media, this.metadata});

  MessageModel.fromJson(Map<String, dynamic> json) {
    messageString = json['messageString'];
    chatId = json['chatId'];
    media = json['media'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageString'] = messageString;
    data['chatId'] = chatId;
    data['media'] = media;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class Metadata extends HiveObject {
  @HiveField(0)
  String? dateTimeSent;
  @HiveField(1)
  String? toDestinationId;
  @HiveField(2)
  String? fromUserId;

  Metadata({this.dateTimeSent, this.toDestinationId, this.fromUserId});

  Metadata.fromJson(Map<String, dynamic> json) {
    dateTimeSent = json['dateTimeSent'];
    toDestinationId = json['toDestinationId'];
    fromUserId = json['fromUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateTimeSent'] = dateTimeSent;
    data['toDestinationId'] = toDestinationId;
    data['fromUserId'] = fromUserId;
    return data;
  }
}
