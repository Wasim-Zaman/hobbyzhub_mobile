import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/chat/private/private_chat_cubit.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:hobbyzhub/models/message/message.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/widgets/text_fields/chat_field.dart';

class PrivateMessagingScreen extends StatefulWidget {
  final PrivateChat chat;
  final String userId;

  const PrivateMessagingScreen(
      {Key? key, required this.chat, required this.userId})
      : super(key: key);

  @override
  State<PrivateMessagingScreen> createState() => _PrivateMessagingScreenState();
}

class _PrivateMessagingScreenState extends State<PrivateMessagingScreen> {
  var messageController = TextEditingController();
  String message = '';

  late var otherUser;
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    otherUser = widget.chat.participants!
        .firstWhere((element) => element.userId.toString() != widget.userId);
  }

  sendMessage({
    required String message,
    required String room,
    File? media,
    required Map createMetadataRequest,
  }) {
    ChatCubit.get(context).sendMessage(
      message: message,
      room: room,
      createMetadataRequest: createMetadataRequest,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(otherUser.profileImage.toString()),
              onBackgroundImageError: (exception, stackTrace) => const Icon(
                Icons.person,
                size: 30,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              otherUser.fullName.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            )),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where('room', isEqualTo: widget.chat.room.toString())
            // .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          // convert the snapshots to the model
          messages = snapshot.data!.docs
              .map(
                  (doc) => Message.fromJson(doc.data() as Map<String, dynamic>))
              .toList()
            ..reversed;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: messages[index],
                        myUserId: widget.userId,
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ChatField(
                        controller: messageController,
                        hintText: 'Write your message',
                        suffixIcon: BlocListener<ChatCubit, ChatState>(
                          listener: (context, state) {
                            if (state is ChatSendMessageLoading) {
                              message = messageController.text;
                              messageController.clear();
                            } else if (state is ChatSendMessageSuccess) {
                              messageController.clear();
                            } else {
                              messageController.text = message;
                            }
                          },
                          child: IconButton(
                            onPressed: () async {
                              String? myId =
                                  await UserSecureStorage.fetchUserId();
                              sendMessage(
                                message: messageController.text,
                                room: widget.chat.room.toString(),
                                createMetadataRequest: {
                                  "room": widget.chat.room.toString(),
                                  "sender": myId
                                },
                              );
                            },
                            icon: const Icon(Icons.send),
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final String myUserId;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.myUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message.metadata?.sender.toString() == myUserId;
    Timestamp timestamp = message.timeStamp as Timestamp;
    DateTime dateTime = timestamp.toDate();

    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 50 : 0,
        right: isMe ? 0 : 50,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(32),
                      topRight: const Radius.circular(32),
                      bottomLeft: isMe
                          ? const Radius.circular(32)
                          : const Radius.circular(0),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    message.message
                        .toString(), // Adjust according to your message structure
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                  ),
                  child: Text("${dateTime.hour}:${dateTime.minute}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
