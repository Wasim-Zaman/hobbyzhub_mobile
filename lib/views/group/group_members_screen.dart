import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';

class GroupMembersScreen extends StatelessWidget {
  final List? members;
  const GroupMembersScreen({Key? key, this.members}) : super(key: key);
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
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                onTap: () {
                  context.read<ChatBloc>().add(ChatCreateNewPrivateCatEvent(
                      otherUserId: members![index].userId!));
                },
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
      ),
    );
  }
}
