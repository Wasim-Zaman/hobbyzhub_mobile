import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/users/user_controller.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:nb_utils/nb_utils.dart';

part 'user_events.dart';
part 'user_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    List<User> users = [];
    // Search users based on his full name
    on<UserSearchByNameEvent>((event, emit) async {
      emit(UserSearchByNameLoading());
      try {
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await UserController.searchUsersByName(
            slug: event.slug,
            page: event.page,
            pageSize: event.pageSize,
          );
          users = response.data;
          if (users.isNotEmpty) {
            emit(UserSearchByNameSuccess(users: users));
          } else {
            emit(UserSearchByNameEmpty());
          }
        }
      } catch (error) {
        emit(UserSearchByNameFailure(message: error.toString()));
      }
    });

    on<UserSearchByNameMoreEvent>((event, emit) async {
      try {
        var networkStatus = await isNetworkAvailable();
        if (networkStatus) {
          final response = await UserController.searchUsersByName(
            slug: event.slug,
            page: event.page,
            pageSize: event.pageSize,
          );
          users = response.data;
          if (users.isNotEmpty) {
            emit(UserSearchByNameMoreSuccess(users: users));
          } else {
            emit(UserSearchByNameEmpty());
          }
        }
      } catch (error) {
        emit(UserSearchByNameFailure(message: error.toString()));
      }
    });
  }
}
