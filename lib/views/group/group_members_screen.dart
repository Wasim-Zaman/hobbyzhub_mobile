import 'package:flutter/material.dart';
import 'package:hobbyzhub/models/user/user.dart';

class GroupMembersScreen extends StatelessWidget {
  final List<User>? members;
  const GroupMembersScreen({Key? key, this.members}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage:
                    NetworkImage(members![index].profileImage ?? ""),
                onBackgroundImageError: (exception, stackTrace) => const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              title: Text(members![index].fullName!),
            ),
          );
        },
        itemCount: members?.length,
      ),
    );
  }
}
