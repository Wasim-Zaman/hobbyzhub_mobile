import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String? userId;

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
          title: const Text('Chat List'),
        ),
        body: userId == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('ChatRoom')
                    .where('participants', arrayContains: userId.toString())
                    .where('type', isEqualTo: 'one-to-one')
                    // .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => ListTile(
                        title:
                            Text(snapshot.data!.docs[index].data()['title'])),
                  );
                },
              ));
  }
}
