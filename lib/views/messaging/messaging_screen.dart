// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/chat_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/utils/app_date.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/widgets/chat/message_bubble.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/chat_field.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class MessagingScreen extends StatefulWidget {
  final ChatModel chat;
  const MessagingScreen({super.key, required this.chat});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  late StompClient stompClient;
  late String? myUserId;

  // Lists
  List<MessageModel> messages = [];
  List<File>? mediaFiles = [];

  // Controllers
  var chatScrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  // pagination
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
              ChatGetMessagesEvent(page, size, chatId: widget.chat.chatId!));
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
        .read<ChatBloc>()
        .add(ChatGetLocalMessagesEvent(chatId: widget.chat.chatId!));
    print('Connected as $myUserId');
    print('chat id: ${widget.chat.chatId}');
    stompClient.subscribe(
      destination: '/queue/user-$myUserId',
      callback: (frame) {
        print("hello");
        if (frame.binaryBody != null) {
          try {
            var decodedData = utf8.decode(frame.binaryBody!);
            var message = MessageModel.fromJson(jsonDecode(decodedData));

            context.read<ChatBloc>()
              ..add(ChatReceiveMessageEvent(message: message))
              ..add(ChatSetLocalMessageEvent(
                message: message,
                chatId: widget.chat.chatId!,
              ));
          } on FormatException catch (e) {
            log("Error decoding message: $e");
          }
        }
      },
    );
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      try {
        var chatId = widget.chat.chatId.toString();
        var message = MessageModel(
          messageString: _messageController.text,
          chatId: widget.chat.chatId,
          media: null,
          metadata: Metadata(
            dateTimeSent: AppDate.generateTimeString(),
            toDestinationId: widget.chat.chatParticipantB?.userId,
            fromUserId: myUserId,
          ),
        );
        stompClient.send(
          destination: '/app/private',
          body: jsonEncode(message.toJson()),
          headers: {},
        );
        // save the message to the list of messages
        context.read<ChatBloc>()
          ..add(ChatSendMessageEvent(message: message))
          ..add(ChatSetLocalMessageEvent(message: message, chatId: chatId));
        _messageController.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    stompClient.deactivate();
    _messageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var participant = widget.chat.chatParticipantB;
    return Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: ImageWidget(
                  imageUrl: participant?.profileImage ?? "",
                  width: 45.w,
                  height: 45.h,
                  errorWidget: Image.asset(ImageAssets.profileImage),
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      participant?.fullName ?? "",
                      style: AppTextStyle.listTileTitle,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Active now',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.subcategoryUnSelectedTextStyle,
                  )
                ],
              ),
            ],
          ),
        ),
        actions: [
          Image.asset(ImageAssets.searchImage, height: 25.h),
          SizedBox(
            width: 10.w,
          ),
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
                    Text('Clear Chat', style: AppTextStyle.listTileSubHeading)
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
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatMessageSentState) {
            messages.insert(0, state.message);
          } else if (state is ChatMessageReceivedState) {
            messages.insert(0, state.message);
          } else if (state is ChatGetMessagesSuccessState) {
            // append from reverse side
            messages.insertAll(0, state.messages);
          } else if (state is ChatGetLocalMessagesSuccessState) {
            messages = state.messages;
            // reverse the message list
            messages = messages.reversed.toList();
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
                            MessageBubble(
                              message: messages[index],
                              myUserId: myUserId.toString(),
                              imageUrl: participant!.profileImage.toString(),
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ChatField(
                        controller: _messageController,
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
                //               controller: _messageController,
                //               decoration: InputDecoration(
                //                 border: InputBorder.none,
                //                 hintText: 'Write your message',
                //                 // prefixIcon: IconButton(
                //                 //   onPressed: () {},
                //                 //   icon: Icon(Icons.attach_file),
                //                 // ),
                //               ),
                //               style:
                //                   AppTextStyle.subcategoryUnSelectedTextStyle,
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
      ),
    );
  }
}
