import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/explore/explore_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/category/category_model.dart';
import 'package:hobbyzhub/models/post_model/post.dart';
import 'package:hobbyzhub/models/user/user.dart';
import 'package:hobbyzhub/utils/app_exceptions.dart';
import 'package:nb_utils/nb_utils.dart';

part 'explore_states.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  static ExploreCubit get(context) => BlocProvider.of<ExploreCubit>(context);

  // Lists
  List<Post> posts = [];
  List<User> users = [];
  List<CategoryModel> hobbyz = [];
  List<Post> hobbyzPosts = [];

  // pagination
  int initialRandomPostsPage = 0;
  int initialRandomPostsSize = 20;
  int initialRandomUsersPage = 0;
  int initialRandomUsersSize = 20;
  int hobbiesPage = 0, hobbiesSize = 50;
  int hobbiesPostsPage = 0, hobbiesPostsSize = 50;

  getRandomUsers() async {
    emit(ExploreGetRandomUsersLoading());

    try {
      // check internet connection
      var networkStatus = await isNetworkAvailable();
      if (!networkStatus) {
        emit(ExploreGetRandomUsersError(message: "No internet connection"));
        return;
      }
      var res = await ExploreController.getRandomUsers(
        initialRandomUsersPage,
        initialRandomUsersSize,
      );
      if (res.data.isEmpty) {
        emit(ExploreGetRandomUsersEmpty());
      } else {
        emit(ExploreGetRandomUsersSuccess(res: res));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ExploreGetRandomUsersError(message: err.toString()));
      } else {
        emit(ExploreGetRandomUsersError(
          message: "An error occurred while getting random users",
        ));
      }
    }
  }

  getRandomPosts() async {
    emit(ExploreGetRandomPostsLoading());

    try {
      // check internet connection
      var networkStatus = await isNetworkAvailable();
      if (!networkStatus) {
        emit(ExploreGetRandomPostsError(message: "No internet connection"));
        return;
      }
      var res = await ExploreController.getRandomPosts(
        initialRandomPostsPage,
        initialRandomPostsSize,
      );
      if (res.data.isEmpty) {
        emit(ExploreGetRamdomPostsEmpty());
      } else {
        emit(ExploreGetRandomPostsSuccess(res: res));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ExploreGetRandomPostsError(message: err.toString()));
      } else {
        emit(ExploreGetRandomPostsError(
          message: "An error occurred while getting random posts",
        ));
      }
    }
  }

  getMoreRandomUsers() async {
    initialRandomUsersPage++;
    emit(ExploreGetMoreRandomUsersLoading());
    // check internet connection
    var networkStatus = await isNetworkAvailable();
    if (!networkStatus) {
      return;
    }
    // await Future.delayed(const Duration(seconds: 3));
    var res = await ExploreController.getRandomUsers(
      initialRandomUsersPage,
      initialRandomUsersSize,
    );
    emit(ExploreGetMoreRandomUsersSuccess(res: res));
  }

  getMoreRandomPosts() async {
    initialRandomPostsPage++;
    emit(ExploreGetMoreRandomPostsLoading());
    // check internet connection
    var networkStatus = await isNetworkAvailable();
    if (!networkStatus) {
      return;
    }
    var res = await ExploreController.getRandomPosts(
      initialRandomPostsPage,
      initialRandomPostsSize,
    );
    emit(ExploreGetMoreRandomPostsSuccess(res: res));
  }

  getSubscribedHobbyz() async {
    try {
      emit(ExploreGetSubscribedHobbyzLoading());

      // check internet connection
      var networkStatus = await isNetworkAvailable();
      if (!networkStatus) {
        emit(
          ExploreGetSubscribedHobbyzError(message: "No internet connection"),
        );
        return;
      }
      var res = await ExploreController.getSubscribedHobbyz(
        hobbiesPage,
        hobbiesSize,
      );
      if (res.data.isEmpty) {
        emit(ExploreGetSubscribedHobbyzEmpty());
      } else {
        emit(ExploreGetSubscribedHobbyzSuccess(res: res));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ExploreGetSubscribedHobbyzError(message: err.toString()));
      } else {
        emit(ExploreGetSubscribedHobbyzError(
          message: "An error occurred while getting random posts",
        ));
      }
    }
  }

  getMoreSubscribedHobbyz() async {
    hobbiesPage++;
    // check internet connection
    var networkStatus = await isNetworkAvailable();
    if (!networkStatus) {
      return;
    }
    var res = await ExploreController.getSubscribedHobbyz(
      hobbiesPage,
      hobbiesSize,
    );
    emit(ExploreGetMoreSubscribedHobbyzSuccess(res: res));
  }

  getHobbyPosts(String hobbyId) async {
    hobbiesPostsPage = 0;
    hobbiesPostsSize = 50;
    emit(ExploreGetHobbyzPostsLoading());
    try {
// check internet connection
      var networkStatus = await isNetworkAvailable();
      if (!networkStatus) {
        return;
      }

      var res = await ExploreController.getHobbyPosts(
        hobbyId,
        hobbiesPostsPage,
        hobbiesPostsSize,
      );
      if (res.data.isEmpty) {
        emit(ExploreGetHobbyzPostsEmpty());
      } else {
        emit(ExploreGetHobbyzPostsSuccess(res: res));
      }
    } catch (err) {
      if (err is ErrorException) {
        emit(ExploreGetHobbyzPostsError(message: err.toString()));
      } else {
        emit(ExploreGetHobbyzPostsError(
          message: "An error occurred while getting hobbyz posts",
        ));
      }
    }
  }

  getMoreHobbyPosts(String hobbyId) async {
    hobbiesPostsPage++;
    // check internet connection
    var networkStatus = await isNetworkAvailable();
    if (!networkStatus) {
      return;
    }
    var res = await ExploreController.getHobbyPosts(
      hobbyId,
      hobbiesPostsPage,
      hobbiesPostsSize,
    );
    emit(ExploreGetMoreHobbyzPostsSuccess(res: res));
  }
}
