import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
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
  final ChatBloc bloc = ChatBloc();
  late var otherUser;

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
    bloc.add(ChatSendNewMessageEvent(
      message: message,
      room: room,
      media: media,
      createMetadataRequest: createMetadataRequest,
    ));
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return MessageBubble(
                        message: data,
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
                        suffixIcon: IconButton(
                          onPressed: () async {
                            String? myId =
                                await UserSecureStorage.fetchUserId();
                            String otherId = widget.chat.participantIds!
                                .firstWhere((element) =>
                                    element.toString() != myId.toString());
                            sendMessage(
                              message: messageController.text,
                              room: widget.chat.room.toString(),
                              createMetadataRequest: {
                                "room": widget.chat.room.toString(),
                                "receiver": otherId,
                                "sender": "$myId",
                              },
                            );
                          },
                          icon: const Icon(Icons.send),
                          color: AppColors.primary,
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
  final Map<String, dynamic> message;
  final String myUserId;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.myUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMe = message['metaData']['sender'] == myUserId;
    Timestamp timestamp = message['timestamp'];
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
                    message['message']
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
