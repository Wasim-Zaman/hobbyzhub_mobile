import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/follower/follower_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'follower_events_states.dart';

class FollowerBloc extends Bloc<FollowerEvent, FollowerState> {
  FollowerBloc() : super(FollowerInitialState()) {
    on<FollowerEvent>((event, emit) async {
      if (event is FollowerGetInitialEvent) {
        emit(FollowerLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response = await FollowerController.getMyFollowers();
            emit(FollowerGetInitialState(response: response));
          } else {
            emit(FollowerErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FollowerErrorState(message: err.toString()));
        }
      }
    });
  }
}
