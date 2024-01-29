import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/follower/f_and_f_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'f_and_f_events_states.dart';

class FAndFBloc extends Bloc<FAndFEvent, FAndFState> {
  FAndFBloc() : super(FAndFInitialState()) {
    on<FAndFEvent>((event, emit) async {
      if (event is FAndFInitialFollowersEvent) {
        emit(FAndFLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response = await FAndFController.getMyFollowers();
            emit(FAndFInitialFollowersState(response: response));
          } else {
            emit(FAndFErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FAndFErrorState(message: err.toString()));
        }
      } else if (event is FAndFMoreFollowersEvent) {
        // ...
      } else if (event is FAndFInitialFollowingEvent) {
        emit(FAndFLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response = await FAndFController.getMyFollowings();
            emit(FAndFInitialFollowingState(response: response));
          } else {
            emit(FAndFErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FAndFErrorState(message: err.toString()));
        }
      } else if (event is FAndFMoreFollowingEvent) {
        //...
      } else if (event is FAndFInitialOtherFollowersEvent) {
        emit(FAndFLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response =
                await FAndFController.getOtherFollowers(event.otherUserId);
            emit(FAndFInitialFollowersState(response: response));
          } else {
            emit(FAndFErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FAndFErrorState(message: err.toString()));
        }
      } else if (event is FAndFMoreOtherFollowersEvent) {
        // ...
      } else if (event is FAndFInitialOtherFollowingEvent) {
        emit(FAndFLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response =
                await FAndFController.getOtherFollowings(event.otherUserId);
            emit(FAndFInitialFollowingState(response: response));
          } else {
            emit(FAndFErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FAndFErrorState(message: err.toString()));
        }
      } else if (event is FAndFMoreOtherFollowingEvent) {
        //...
      } else if (event is FAndFFollowUnfollowEvent) {
        emit(FAndFLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response = await FAndFController.followUnfollow(
                otherUserId: event.otherUserId);
            emit(FAndFFollowUnfollowState(response: response));
          } else {
            emit(FAndFErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FAndFErrorState(message: err.toString()));
        }
      } else if (event is FAndFCheckFollowingEvent) {
        emit(FAndFLoadingState());
        try {
          var networkStatus = await isNetworkAvailable();
          if (networkStatus) {
            var response =
                await FAndFController.checkFollowing(event.otherUserId);
            emit(FAndFCheckState(response: response));
          } else {
            emit(FAndFErrorState(message: "No Internet Connection"));
          }
        } catch (err) {
          emit(FAndFErrorState(message: err.toString()));
        }
      }
    });
  }
}
