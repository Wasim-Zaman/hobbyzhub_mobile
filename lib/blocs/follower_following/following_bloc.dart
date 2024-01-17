import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/follower/follower_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'following_events_states.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  FollowingBloc() : super(FollowingInitialState()) {
    on<FollowingEvent>((event, emit) async {
      if (event is FollowingGetInitialEvent) {
        emit(FollowingLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response = await FollowerController.getMyFollowings();
            emit(FollowingGetInitialState(response: response));
          } else {
            emit(FollowingErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FollowingErrorState(message: err.toString()));
        }
      } else if (event is FollowingFollowUnfollowEvent) {
        emit(FollowingLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response = await FollowerController.followUnfollow(
                otherUserId: event.otherUserId);
            emit(FollowingFollowUnfollowState(response: response));
          } else {
            emit(FollowingErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FollowingErrorState(message: err.toString()));
        }
      } else if (event is FollowingCheckEvent) {
        emit(FollowingLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response =
                await FollowerController.checkFollowing(event.otherUserId);
            emit(FollowingCheckState(response: response));
          } else {
            emit(FollowingErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FollowingErrorState(message: err.toString()));
        }
      }
    });
  }
}
