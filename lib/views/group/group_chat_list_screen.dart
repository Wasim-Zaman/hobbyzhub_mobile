import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/group/create_group_screen.dart';
import 'package:hobbyzhub/views/widgets/list_tile/group_chat_tile.dart';

class GroupChatListScreen extends StatefulWidget {
  const GroupChatListScreen({super.key});

  @override
  State<GroupChatListScreen> createState() => _GroupChatListScreenState();
}

class _GroupChatListScreenState extends State<GroupChatListScreen> {
  String? userId;
  List<GroupChat> groups = [];

  @override
  void initState() {
    UserSecureStorage.fetchUserId().then((id) {
      setState(() {
        userId = id;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List', style: AppTextStyle.headings),
        actions: [
          IconButton(
            icon: Image.asset(
              ImageAssets.addNewMessageImage,
              height: 25.h,
              width: 25.w,
            ),
            onPressed: () {
              AppNavigator.goToPage(
                context: context,
                screen: const CreateGroupScreen(),
              );
            },
          ),
        ],
      ),
      body: userId == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('group-chats')
                  .where('type', isEqualTo: 'GROUP')
                  .where('participantIds', arrayContains: userId.toString())
                  // .orderBy('lastMessage.timestamp', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                groups = snapshot.data!.docs
                    .map((e) => GroupChat.fromJson(e.data()))
                    .toList();

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "All Groups",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: groups.length,
                          itemBuilder: (ctx, index) {
                            return Dismissible(
                              key: Key(
                                groups[index].participantIds!.firstWhere(
                                      (id) => id == userId,
                                    ),
                              ),
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm"),
                                      content: const Text(
                                          "Are you sure you want to delete this chat?"),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text("DELETE")),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text("CANCEL"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) {
                                // remove the group from the list
                                groups.removeAt(index);
                              },
                              background: Container(color: Colors.red),
                              child: GroupChatTile(
                                group: groups[index],
                                userId: userId!,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
