class MessageModel {
  String? message;
  String? fromUserId;
  String? toUserId;
  String? dateTimeSent;
  String? type;
  String? chatId;

  MessageModel(
      {this.message,
      this.fromUserId,
      this.toUserId,
      this.dateTimeSent,
      this.type,
      this.chatId});

  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
    dateTimeSent = json['dateTimeSent'];
    type = json['type'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['fromUserId'] = fromUserId;
    data['toUserId'] = toUserId;
    data['dateTimeSent'] = dateTimeSent;
    data['type'] = type;
    data['chatId'] = chatId;
    return data;
  }
}
