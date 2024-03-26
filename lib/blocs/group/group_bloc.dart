import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hobbyzhub/controllers/chat/chat_controller.dart';
import 'package:hobbyzhub/controllers/group/group_controller.dart';
import 'package:hobbyzhub/models/group/group_model.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:nb_utils/nb_utils.dart';

part 'group_events.dart';
part 'group_states.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  static GroupBloc get(context) => context.read<GroupBloc>();

  GroupBloc() : super(GroupInitialState()) {
    on<GroupCreateMediaEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        // API logic
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await GroupController().createMedia(event.media);
          emit(GroupCreateMediaState(mediaUrl: response['data']));
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });

    on<GroupCreateEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        // API logic
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          File? groupImage = event.body['groupImage'];
          String title = event.body['title'];
          String groupDescription = event.body['groupDescription'];
          List<Map<String, dynamic>> adminIds = event.body['adminIds'];
          List<Map<String, dynamic>> participantRequests =
              event.body['participantRequests'];

          final response = await ChatController.createGroupChat(
            groupImage: groupImage,
            adminIds: adminIds,
            participantIds: participantRequests,
            title: title,
            description: groupDescription,
          );
          emit(GroupCreateGroupState(group: response.data));
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });

    on<GroupGetChatsEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        // API logic
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await GroupController().getGroupChats(
            memberId: event.memberId,
          );

          emit(GroupGetChatsState(chats: response.data));
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });

    on<GroupGetMoreChatsEvent>((event, emit) async {
      try {
        // API logic
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await GroupController().getGroupChats();
          emit(GroupGetChatsState(chats: response.data));
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });

    on<GroupReceiveMessagesEvent>((event, emit) async {
      // Store the message locally in the give database under the chat id
      var chatBox = await Hive.openBox<MessageModel>(event.groupId);
      chatBox.add(event.message);

      // If there are more than 100 messages, remove the oldest one
      if (chatBox.length > 100) {
        chatBox.deleteAt(0);
      }
      emit(GroupReceiveMessageState(message: event.message));
      chatBox.close();
    });

    on<GroupGetLocalMessagesEvent>((event, emit) async {
      // Get the messages from the local database
      var chatBox = await Hive.openBox<MessageModel>(event.groupId);
      emit(GroupGetLocalMessagesState(messages: chatBox.values.toList()));
      chatBox.close();
    });

    on<GroupGetDetailsEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        // API logic
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response =
              await GroupController().getGroupDetails(event.chatId);
          emit(GroupGetDetailsState(group: response.data));
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });

    on<GroupAddMemberEvent>((event, emit) async {
      emit(GroupLoadingState());
      try {
        // API logic
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          await GroupController().addMemberToTheGroup(
            groupChatId: event.chatId,
            memberId: event.memberId,
          );
          emit(GroupAddMemberState());
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });
  }
}
