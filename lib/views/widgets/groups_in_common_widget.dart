import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/views/widgets/list_tile/group_chat_tile.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';

class GroupsInCommonWidget extends StatefulWidget {
  final String otherUserId;
  final String? myId;
  const GroupsInCommonWidget({super.key, required this.otherUserId, this.myId});

  @override
  State<GroupsInCommonWidget> createState() => _GroupsInCommonWidgetState();
}

class _GroupsInCommonWidgetState extends State<GroupsInCommonWidget> {
  List<GroupChat> groups = [];
  @override
  void initState() {
    super.initState();

    print(widget.otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
              stream: widget.myId == null
                  ? FirebaseFirestore.instance
                      .collection('group-chats')
                      // .where('type', isEqualTo: 'GROUP')
                      .where('participantIds',
                          arrayContains: widget.otherUserId.toString())
                      // .orderBy('lastMessage.timestamp', descending: true)
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('group-chats')
                      .where('type', isEqualTo: 'GROUP')
                      .where('participantIds', arrayContainsAny: [
                      widget.otherUserId.toString(),
                      widget.myId.toString()
                    ])
                      // .orderBy('lastMessage.timestamp', descending: true)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: LoadingWidget(),
                  );
                }

                groups = snapshot.data!.docs
                    .map((doc) => GroupChat.fromJson(doc.data()))
                    .toList();
                return ListView.builder(
                  itemBuilder: (context, index) => GroupChatTile(
                    group: groups[index],
                    userId: widget.otherUserId,
                  ),
                  itemCount: groups.length,
                );
              }),
        ),
      ],
    );
  }
}
