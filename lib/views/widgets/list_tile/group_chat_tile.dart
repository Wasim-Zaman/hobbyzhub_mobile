import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/group/group_messaging_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class GroupChatTile extends StatelessWidget {
  final GroupChat group;
  final String userId;
  const GroupChatTile({Key? key, required this.group, required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToPage(
            context: context,
            screen: GroupMessagingScreen(
              chat: group,
            ));
      },
      child: Container(
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
                group.groupImage ?? '',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.title.toString()),
                  if (group.lastMessage != null)
                    Text(
                      group.lastMessage!.message.toString(),
                    ).visible(group.lastMessage != null ||
                        group.lastMessage?.message != null),
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateTime.parse(group.timeStamp!.toDate().toString()).timeAgo,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Badge(
                  label: Text(
                    group.unread![userId].toString(),
                  ),
                  backgroundColor: AppColors.primary,
                ).visible(
                  group.unread!.containsKey(userId) &&
                      group.unread![userId] != 0,
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
