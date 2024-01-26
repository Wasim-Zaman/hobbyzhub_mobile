import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _recipientIdController = TextEditingController();
  final TextEditingController _senderIdController = TextEditingController();
  final List<Map<String, dynamic>> _receivedMessages = [];
  late StompClient stompClient;

  @override
  void initState() {
    super.initState();
    initializeSocket();
  }

  initializeSocket() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://149.28.232.132:9101/ws-registry',
        beforeConnect: () async {
          print("Connecting...");
        },
        onConnect: onConnectCallback,
        onStompError: (p0) {
          print("Stomp error ${p0.body}");
        },
        onWebSocketError: (p0) {
          print("Websocket error ${p0}");
        },
        onUnhandledFrame: (p0) {
          print("Unhandled frame ${p0}");
        },
        onUnhandledMessage: (p0) {
          print("Unhandled message ${p0}");
        },
      ),
    );

    // stompClient = StompClient(
    //     config: StompConfig(
    //   url: 'http://149.28.232.132:9101/ws-registry',
    //   beforeConnect: () async {
    //     print("Before connect");
    //   },
    //   onConnect: onConnectCallback,
    //   onWebSocketError: (dynamic error) => print(error),
    //   onStompError: (StompFrame error) => print("Stomp error ${error.body}"),
    //   stompConnectHeaders: {},
    //   webSocketConnectHeaders: {},
    //   useSockJS: true,
    // ));
    stompClient.activate();
  }

  void onConnectCallback(StompFrame connectFrame) {
    _senderIdController.text = 'ws5678';
    _recipientIdController.text = 'ws1234';
    stompClient.subscribe(
      destination: '/queue/user-${_senderIdController.text}',
      callback: (frame) {
        if (frame.binaryBody != null) {
          try {
            var decodedData = utf8.decode(frame.binaryBody!);
            print("Received message: $decodedData");
            // assing the message to the list of messages
            setState(() {
              _receivedMessages.add(jsonDecode(decodedData));
            });
          } on FormatException catch (e) {
            print("Error decoding message: $e");
          }
        }
      },
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty &&
        _recipientIdController.text.isNotEmpty &&
        _senderIdController.text.isNotEmpty) {
      var date = DateTime.now().toIso8601String();
      stompClient.send(
        destination: '/app/private',
        body: jsonEncode({
          'message': _messageController.text,
          'fromUserId': _senderIdController.text,
          'toUserId': _recipientIdController.text,
          'dateSent': date,
        }),
        headers: {},
      );
      // save the message to the list of messages
      setState(() {
        _receivedMessages.add({
          'message': _messageController.text,
          'fromUserId': _senderIdController.text,
          'toUserId': _recipientIdController.text,
          'dateSent': date,
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _senderIdController,
              decoration: const InputDecoration(labelText: 'Your ID'),
              // onSubmitted: (_) => onConnectCallback(StompFrame(command: '')),
            ),
            TextField(
              controller: _recipientIdController,
              decoration: const InputDecoration(labelText: 'Recipient ID'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _receivedMessages.length,
                itemBuilder: (context, index) {
                  final message = _receivedMessages[index];
                  return message['fromUserId'] == _senderIdController.text
                      ? Container(
                          alignment: Alignment.centerRight,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(message['message']),
                            ),
                          ),
                        )
                      : Container(
                          alignment: Alignment.centerLeft,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(message['message']),
                            ),
                          ),
                        );
                },
              ),
            ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message'),
            ),
            ElevatedButton(
              onPressed: _sendMessage,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    stompClient.deactivate();
    _messageController.dispose();
    _recipientIdController.dispose();
    _senderIdController.dispose();
    super.dispose();
  }
}
