class MessageModel {
  String? fromUserId;
  String? toUserId;
  String? message;
  String? dateSent;
  String? messageType;

  MessageModel(
      {this.fromUserId,
      this.toUserId,
      this.message,
      this.dateSent,
      this.messageType});

  MessageModel.fromJson(Map<String, dynamic> json) {
    fromUserId = json['fromUserId'];
    toUserId = json['toUserId'];
    message = json['message'];
    dateSent = json['dateSent'];
    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromUserId'] = fromUserId;
    data['toUserId'] = toUserId;
    data['message'] = message;
    data['dateSent'] = dateSent;
    data['messageType'] = messageType;
    return data;
  }
}
