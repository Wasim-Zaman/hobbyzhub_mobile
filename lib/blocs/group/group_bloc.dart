import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/group/group_controller.dart';
import 'package:nb_utils/nb_utils.dart';

part 'group_events.dart';
part 'group_states.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
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
          final response = await GroupController().createNewGroup(
            body: event.body,
          );
          emit(GroupCreateGroupState());
        } else {
          emit(GroupErrorState(message: 'No internet connection'));
        }
      } catch (error) {
        emit(GroupErrorState(message: error.toString()));
      }
    });
  }
}
