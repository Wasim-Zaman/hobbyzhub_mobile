import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:hobbyzhub/controllers/get_post/get_post_controller.dart';
import 'package:hobbyzhub/models/story/get_story_model.dart';
import 'package:meta/meta.dart';

part 'get_stories_state.dart';

class GetStoriesCubit extends Cubit<GetStoriesState> {
  GetStoriesCubit() : super(GetStoriesInitial());

  GetPostController getStoriesController = GetPostController();

  List<GetStoriesModel> storiesModelList = [];

  getStoriesList() async {
    emit(GetStoriesLoading(storiesList: storiesModelList));
    try {
      var response = await getStoriesController.getStories();
      log("STORIES");
      log(response.body);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        var storiesList =
            jsonResponse.map((json) => GetStoriesModel.fromJson(json)).toList();
        emit(GetStoriesLoaded(storiesList: storiesList));
      } else {
        storiesModelList = [];
        emit(GetStoriesFailed());
      }
    } on SocketException {
      emit(GetStoriesInternetError());
    } catch (e) {
      log(e.toString());
      emit(GetStoriesFailed());
    }
  }
}
