import 'package:hobbyzhub/models/user/user.dart';

class GroupModel {
  String? chatId;
  String? type;
  String? groupName;
  String? groupDescription;
  String? groupIcon;
  String? dateTimeCreated;
  List<User>? chatParticipants;
  List<User>? chatAdmins;

  GroupModel({
    this.chatId,
    this.type,
    this.groupName,
    this.groupDescription,
    this.groupIcon,
    this.dateTimeCreated,
    this.chatParticipants,
    this.chatAdmins,
  });

  GroupModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    type = json['type'];
    groupName = json['groupName'];
    groupDescription = json['groupDescription'];
    groupIcon = json['groupIcon'];
    dateTimeCreated = json['dateTimeCreated'];

    if (json['chatParticipants'] != null) {
      chatParticipants = <User>[];
      json['chatParticipants'].forEach((participant) {
        chatParticipants!.add(User.fromJson(participant));
      });
    }

    if (json['chatAdmins'] != null) {
      chatAdmins = <User>[];
      json['chatAdmins'].forEach((admin) {
        chatAdmins!.add(User.fromJson(admin));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['type'] = type;
    data['groupName'] = groupName;
    data['groupDescription'] = groupDescription;
    data['groupIcon'] = groupIcon;
    data['dateTimeCreated'] = dateTimeCreated;
    if (chatParticipants != null) {
      data['chatParticipants'] =
          chatParticipants!.map((participant) => participant.toJson()).toList();
    }
    if (chatAdmins != null) {
      data['chatAdmins'] = chatAdmins!.map((admin) => admin.toJson()).toList();
    }
    return data;
  }
}
