import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/chat/chat_controller.dart';
import 'package:hobbyzhub/models/chat/private_chat.dart';
import 'package:nb_utils/nb_utils.dart';

part 'private_chat_states.dart';

class PrivateChatCubit extends Cubit<PrivateChatState> {
  PrivateChatCubit() : super(PrivateChatInitial());

  static PrivateChatCubit get(context) => BlocProvider.of(context);

  void createPrivateChat(String otherUserId) async {
    emit(PrivateChatLoading());
    try {
      // check internet connection
      if (await isNetworkAvailable()) {
        var res = await ChatController.startPrivateChat(otherUserId);
        emit(PrivateChatCreate(chat: res.data));
      } else {
        emit(PrivateChatError(message: 'No internet connection'));
      }
    } catch (err) {
      emit(PrivateChatError(message: err.toString()));
    }
  }
}
