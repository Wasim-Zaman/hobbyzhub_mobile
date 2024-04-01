import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/chat/private/private_chat_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:hobbyzhub/models/message/message.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/widgets/loading/paginated_loading.dart';
import 'package:hobbyzhub/views/widgets/text_fields/chat_field.dart';
import 'package:nb_utils/nb_utils.dart';

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
  // * Controllers
  var messageController = TextEditingController();
  var scrollController = ScrollController();

  // * Lists
  List<Message> messages = [];

  // * Others
  String message = '';
  late dynamic otherUser;

  @override
  void initState() {
    super.initState();
    otherUser = widget.chat.participants!
        .firstWhere((element) => element.userId.toString() != widget.userId);

    // use scroll controller to scroll to the last message
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ChatCubit.get(context).getMessages(
          room: widget.chat.room.toString(),
          from: message.length,
        );
      }
    });
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('messages')
              .where('room', isEqualTo: widget.chat.room.toString())
              .orderBy('timestamp', descending: true)
              .limit(10)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Something went wrong! ${snapshot.error.toString()}",
                    style: AppTextStyle.headings,
                  ),
                ],
              );
            }

            if (snapshot.hasData) {
              // convert the snapshots to the model
              messages = snapshot.data!.docs
                  .map((doc) =>
                      Message.fromJson(doc.data() as Map<String, dynamic>))
                  .toList();
            }

            return Column(
              children: [
                Expanded(
                  child: BlocConsumer<ChatCubit, ChatState>(
                    listener: (context, state) {
                      if (state is ChatGetMessagesSuccess) {
                        // append those messages with old messages
                        messages.addAll(state.messages);
                      }
                    },
                    builder: (context, state) {
                      return ListView.builder(
                        reverse: false,
                        itemCount: messages.length + 1,
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          // show loading in loading state
                          if (index == messages.length) {
                            return const PaginatedLoading()
                                .visible(state is ChatGetMessagesLoading);
                          }
                          return MessageBubble(
                            message: messages[index],
                            myUserId: widget.userId,
                          );
                        },
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
                                message: messageController.text.trim(),
                                room: widget.chat.room.toString(),
                                createMetadataRequest: {
                                  "room": widget.chat.room.toString(),
                                  "sender": myId
                                },
                              );
                            },
                            icon: const Icon(Icons.send),
                            color: AppColors.primary,
                          ).visible(messageController.text.isNotEmpty),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
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
