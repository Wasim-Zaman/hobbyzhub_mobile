import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:nb_utils/nb_utils.dart';

class GroupMembersScreen extends StatefulWidget {
  final GroupChat? group;
  const GroupMembersScreen({Key? key, this.group}) : super(key: key);

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  List<Participants>? admins;
  List<Participants>? members;

  @override
  void initState() {
    admins = widget.group?.participants?.where((participant) {
      return widget.group?.adminIds?.contains(participant.userId) ?? false;
    }).toList();

    members = widget.group?.participants?.where((participant) {
      return !(widget.group?.adminIds?.contains(participant.userId) ?? false);
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<ChatBloc, ChatStates>(
        listener: (context, state) {
          if (state is ChatCreatePrivateSuccessState) {
            // AppNavigator.goToPage(
            //   context: context,
            //   screen: MessagingScreen(chat: state.chat),
            // );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Members"),
              20.height,
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        // onTap: () {
                        //   context.read<ChatBloc>().add(
                        //       ChatCreateNewPrivateCatEvent(
                        //           otherUserId: widget
                        //               .group!.participants![index].userId!));
                        // },
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(members![index].profileImage ?? ""),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(members![index].fullName!),
                        trailing: PopupMenuButton(itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 0,
                              child: Text("Remove"),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: Text("Make Admin"),
                            ),
                          ];
                        }),
                      ),
                    );
                  },
                  itemCount: members?.length,
                ),
              ),
              const Divider(),
              const Text("Admins"),
              20.height,
              Expanded(
                child: ListView.builder(
                  itemCount: admins?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(admins![index].profileImage ?? ""),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        title: Text(admins![index].fullName!),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
