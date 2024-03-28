// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/private/private_chat_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/message/message.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/group/group_description_screen.dart';
import 'package:hobbyzhub/views/widgets/chat/message_bubble.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/chat_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class GroupMessagingScreen extends StatefulWidget {
  final GroupChat chat;
  const GroupMessagingScreen({super.key, required this.chat});

  @override
  State<GroupMessagingScreen> createState() => _GroupMessagingScreenState();
}

class _GroupMessagingScreenState extends State<GroupMessagingScreen> {
  String? myUserId;
  String message = '';

  // Controllers
  var messageController = TextEditingController();
  var chatScrollController = ScrollController();

  // Lists
  var messages = <Message>[];

  // Pagination
  int page = 1;
  int size = 100;

  @override
  void initState() {
    super.initState();
    UserSecureStorage.fetchUserId().then((id) {
      setState(() {
        setState(() {
          myUserId = id;
        });
      });
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

  void handleClick(int value) {
    switch (value) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  @override
  void dispose() {
    messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  side:
                      const BorderSide(width: 1.5, color: AppColors.borderGrey),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Center(
                child: Icon(
                  Ionicons.arrow_back,
                  size: 20.sp,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            AppNavigator.goToPage(
                context: context,
                screen: GroupDescriptionScreen(group: widget.chat));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(
                        widget.chat.groupImage ?? ''),
                    child: Text(
                      widget.chat.title!.substring(0, 1).toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ).visible(widget.chat.groupImage.isEmptyOrNull),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.chat.title ?? '',
                      style: AppTextStyle.listTileTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Text(
                '${widget.chat.participants?.length} Members',
                style: AppTextStyle.listTileSubHeading,
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            offset: const Offset(0, 50),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey,
            ),
            elevation: 1,
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                // row with two children
                child: Row(
                  children: [
                    Icon(Ionicons.refresh),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Clear Chat',
                      style: AppTextStyle.listTileSubHeading,
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                // row with two children
                child: Row(
                  children: [
                    Icon(Icons.delete_outline_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Delete Chat',
                      style: AppTextStyle.listTileSubHeading,
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                // row with two children
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.exportImage,
                      height: 30.h,
                      width: 30.h,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Export Chat',
                      style: AppTextStyle.listTileSubHeading,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('room', isEqualTo: widget.chat.room.toString())
                  // .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: LoadingWidget());
                }

                // if (snapshot.hasError) {
                //   return Text(snapshot.error.toString());
                // }

                // convert the snapshots to the model
                messages = snapshot.data!.docs
                    .map((doc) =>
                        Message.fromJson(doc.data() as Map<String, dynamic>))
                    .toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return GroupMessageBubble(
                      message: messages[index],
                      myUserId: myUserId ?? '',
                      group: widget.chat,
                    );
                  },
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          String? myId = await UserSecureStorage.fetchUserId();
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
