// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class MessagingScreen extends StatefulWidget {
  final String userId;
  const MessagingScreen({super.key, required this.userId});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  late StompClient stompClient;
  late String? myUserId;
  List<MessageModel> messages = [];

  @override
  void initState() {
    initializeSocket();
    super.initState();
  }

  final TextEditingController _messageController = TextEditingController();
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
          // myUserId = await UserSecureStorage.fetchUserId();
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

  void onConnectCallback(StompFrame connectFrame) {
    // _senderIdController.text = 'ws5678';
    // _recipientIdController.text = 'ws1234';
    myUserId = 'ws7890';
    print('Connected');
    stompClient.subscribe(
      destination: '/queue/user-$myUserId',
      callback: (frame) {
        if (frame.binaryBody != null) {
          try {
            var decodedData = utf8.decode(frame.binaryBody!);
            log("Received message: $decodedData");

            // assing the message to the list of messages
            context.read<ChatBloc>().add(
                  ChatReceiveMessageEvent(
                    message: MessageModel.fromJson(
                      jsonDecode(decodedData),
                    ),
                  ),
                );
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
        // use utc formate for the date
        var date = DateTime.now().toUtc().toString();
        MessageModel message = MessageModel(
          message: _messageController.text,
          fromUserId: myUserId.toString(),
          toUserId: "ws1234",
          dateSent: date,
        );
        stompClient.send(
          destination: '/app/private',
          body: jsonEncode(message.toJson()),
          headers: {},
        );
        // save the message to the list of messages
        context.read<ChatBloc>().add(ChatSendMessageEvent(message: message));
        _messageController.clear();
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    stompClient.deactivate();

    // before we actually close the chat, i want to cache top 100 messages
    // so that when the user opens the chat again, they can see the last 100 messages
    // this is to avoid making a call to the server to fetch the messages
    // use hive database to do so for last 100 messages

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: 50.w,
                height: 50.h,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r)),
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
                      'Jane Smith',
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
          Image.asset(
            ImageAssets.searchImage,
            height: 25.h,
          ),
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
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatMessageSentState) {
            messages = state.messages;
          } else if (state is ChatMessageReceivedState) {
            messages = state.messages;
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListView.builder(
                  itemCount: messages.length,
                  reverse: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MessageBubble(
                          message: messages[index],
                          myUserId: myUserId.toString(),
                        ),
                      ],
                    );
                  }),
              // Expanded(child: Container()),
              20.height,
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.4,
                    height: 56.h,
                    padding: const EdgeInsets.only(
                      left: 22,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x21000000),
                          blurRadius: 30,
                          offset: Offset(5, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write your message',
                              prefixIcon: Icon(Icons.attach_file),
                            ),
                            style: AppTextStyle.subcategoryUnSelectedTextStyle,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.w),
                          child: IconButton(
                            icon: Icon(Icons.send),
                            color: AppColors.primary,
                            onPressed: () {
                              sendMessage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                      width: 55.w,
                      height: 56.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x21000000),
                            blurRadius: 30,
                            offset: Offset(5, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                        ),
                      )),
                ],
              ),
              Container(height: 20),
            ],
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message; // Replace with your actual Message class
  final String myUserId;

  const MessageBubble(
      {super.key, required this.message, required this.myUserId});

  @override
  Widget build(BuildContext context) {
    bool isMe = message.fromUserId == myUserId;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: isMe ? 0 : 10,
            right: isMe ? 10 : 0,
          ),
          decoration: BoxDecoration(
            color: isMe ? AppColors.primary : Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),
            ),
          ),
          child: Text(
            message.message.toString(), // Replace with your actual text field
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
