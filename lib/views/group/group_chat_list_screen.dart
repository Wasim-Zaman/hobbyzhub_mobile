import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/group/create_group_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class GroupChatListScreen extends StatefulWidget {
  const GroupChatListScreen({super.key});

  @override
  State<GroupChatListScreen> createState() => _GroupChatListScreenState();
}

class _GroupChatListScreenState extends State<GroupChatListScreen> {
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
                  // .where('type', isEqualTo: 'GROUP')
                  // .where('participantIds', arrayContains: userId.toString())
                  // .orderBy('lastMessage.timestamp', descending: true)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var docs = snapshot.data!.docs;

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
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      docs[index]['groupImage'],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(docs[index]['title'].toString()),
                                        Text(docs[index]['lastMessage'] ?? ''),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   DateTime.parse(chats[index]['lastMessage']
                                      //               ['timestamp']
                                      //           .toDate()
                                      //           .toString())
                                      //       .timeAgo,
                                      //   style: TextStyle(
                                      //     color: Colors.grey,
                                      //   ),
                                      // ),
                                      const SizedBox(height: 10),
                                      // timestamp
                                      if (docs[index]['unread'] != null)
                                        Badge(
                                          label: Text(
                                            docs[index]['unread']['$userId']
                                                .toString(),
                                          ),
                                          backgroundColor: AppColors.primary,
                                        ).visible(
                                          docs[index]['unread']['$userId'] !=
                                                  0 ||
                                              docs[index]['unread'] != null,
                                        ),
                                    ],
                                  )),
                                ],
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
