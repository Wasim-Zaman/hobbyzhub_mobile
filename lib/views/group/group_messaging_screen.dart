// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/group/group_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_date.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/widgets/chat/message_bubble.dart';
import 'package:hobbyzhub/views/widgets/text_fields/chat_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class GroupMessagingScreen extends StatefulWidget {
  final GroupModel group;
  const GroupMessagingScreen({super.key, required this.group});

  @override
  State<GroupMessagingScreen> createState() => _GroupMessagingScreenState();
}

class _GroupMessagingScreenState extends State<GroupMessagingScreen> {
  String? myUserId;
  User? myUser;
  late StompClient stompClient;

  // Controllers
  var messageController = TextEditingController();
  var chatScrollController = ScrollController();

  // Lists
  var messages = <MessageModel>[];

  // Pagination
  int page = 1;
  int size = 100;

  @override
  void initState() {
    // go to the last message using scroll controller
    chatScrollController.addListener(() {
      if (chatScrollController.position.pixels ==
          chatScrollController.position.maxScrollExtent) {
        if (messages.length > 100) {
          page++;
          context.read<ChatBloc>().add(
              ChatGetMessagesEvent(page, size, chatId: widget.group.chatId!));
        }
      }
    });
    initializeSocket();

    super.initState();
  }

  void handleClick(int value) {
    switch (value) {
      case 0:
        break;
      case 1:
        break;
    }
  }

  initializeSocket() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: dotenv.env['SOCKET_URL']!,
        beforeConnect: () async {
          myUserId = await UserSecureStorage.fetchUserId();
          log("Connecting...");
          UserSecureStorage.fetchUserId().then((value) {
            myUserId = value;
            for (var element in widget.group.chatParticipants!) {
              if (element.userId == myUserId) {
                myUser = element;
              }
            }
          });
        },
        onConnect: onConnectCallback,
        onStompError: (p0) {
          log("Stomp error ${p0.body}");
        },
        onWebSocketError: (p0) {
          log("Websocket error $p0");
        },
        onUnhandledFrame: (p0) {
          log("Unhandled frame $p0");
        },
        onUnhandledMessage: (p0) {
          log("Unhandled message $p0");
        },
      ),
    );
    stompClient.activate();
  }

  void onConnectCallback(StompFrame connectFrame) async {
    context
        .read<GroupBloc>()
        .add(GroupGetLocalMessagesEvent(groupId: widget.group.chatId!));
    print("Connecting using ${widget.group.chatId}");
    stompClient.subscribe(
      destination: '/topic/group-${widget.group.chatId}',
      callback: (frame) {
        if (frame.binaryBody != null) {
          try {
            var decodedData = utf8.decode(frame.binaryBody!);
            var message = MessageModel.fromJson(jsonDecode(decodedData));
            context.read<GroupBloc>().add(GroupReceiveMessagesEvent(
                  groupId: widget.group.chatId!,
                  message: message,
                ));
          } on FormatException catch (e) {
            log("Error decoding message: $e");
          }
        }
      },
    );
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      try {
        var groupId = widget.group.chatId;
        var message = MessageModel(
          messageString: messageController.text,
          chatId: groupId,
          media: null,
          metadata: Metadata(
            dateTimeSent: AppDate.generateTimeString(),
            toDestinationId: groupId,
            fromUserId: myUserId,
          ),
        );
        stompClient.send(
          destination: '/app/group',
          body: jsonEncode(message.toJson()),
          headers: {},
        );
        // save the message to the list of messages
        // context.read<ChatBloc>()
        //   ..add(ChatSendMessageEvent(message: message))
        //   ..add(ChatSetLocalMessageEvent(message: message, chatId: chatId));

        messageController.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    stompClient.deactivate();
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
        title: SizedBox(
          width: MediaQuery.of(context).size.width / 1.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Text(
                      widget.group.groupName.toString(),
                      style: AppTextStyle.listTileTitle,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '${widget.group.chatParticipants!.length} members',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subcategoryUnSelectedTextStyle,
                  )
                ],
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
      body: BlocConsumer<GroupBloc, GroupState>(
        listener: (context, state) {
          if (state is GroupGetLocalMessagesState) {
            messages = state.messages.reversed.toList();
          } else if (state is GroupReceiveMessageState) {
            messages.insert(0, state.message);
          }
        },
        builder: (context, state) {
          return BlocConsumer<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is ChatGetMessagesSuccessState) {
                // append from reverse side
                messages.insertAll(0, state.messages);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Text('Chat started on ${date.day}'),
                    Expanded(
                      child: ListView.builder(
                          controller: chatScrollController,
                          itemCount: messages.length,
                          reverse: true,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GroupMessageBubble(
                                  message: messages[index],
                                  myUserId: myUserId.toString(),
                                  group: widget.group,
                                ),
                              ],
                            );
                          }),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ChatField(
                            controller: messageController,
                            hintText: 'Write your message',
                            suffixIcon: IconButton(
                              onPressed: sendMessage,
                              icon: Icon(Icons.send),
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 1.4,
                    //       height: 56.h,
                    //       padding: const EdgeInsets.only(
                    //         left: 22,
                    //       ),
                    //       decoration: ShapeDecoration(
                    //         color: Colors.white,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(30),
                    //         ),
                    //         shadows: [
                    //           BoxShadow(
                    //             color: Color(0x21000000),
                    //             blurRadius: 30,
                    //             offset: Offset(5, 4),
                    //             spreadRadius: 0,
                    //           )
                    //         ],
                    //       ),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Expanded(
                    //             child: TextField(
                    //               controller: messageController,
                    //               decoration: InputDecoration(
                    //                 border: InputBorder.none,
                    //                 hintText: 'Write your message',
                    //                 // prefixIcon: IconButton(
                    //                 //   onPressed: () {},
                    //                 //   icon: Icon(Icons.attach_file),
                    //                 // ),
                    //               ),
                    //               style: AppTextStyle
                    //                   .subcategoryUnSelectedTextStyle,
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: EdgeInsets.all(12.w),
                    //             child: IconButton(
                    //               icon: Icon(Icons.send),
                    //               color: AppColors.primary,
                    //               onPressed: sendMessage,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     const SizedBox(width: 10),
                    //     Container(
                    //         width: 55.w,
                    //         height: 56.h,
                    //         decoration: ShapeDecoration(
                    //           color: Colors.white,
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(100),
                    //           ),
                    //           shadows: [
                    //             BoxShadow(
                    //               color: Color(0x21000000),
                    //               blurRadius: 30,
                    //               offset: Offset(5, 4),
                    //               spreadRadius: 0,
                    //             )
                    //           ],
                    //         ),
                    //         child: Center(
                    //           child: Icon(Icons.camera_alt_outlined),
                    //         )).visible(false),
                    //   ],
                    // ),
                    Container(height: 20),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
