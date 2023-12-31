import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/category/category_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'sub_categories_events_states.dart';

class SubCategoriesBloc extends Bloc<SubCategoriesEvent, SubCategoriesState> {
  SubCategoriesBloc() : super(SubCategoriesInitialState()) {
    on<SubCategoriesEvent>((event, emit) async {
      if (event is SubCategoriesFetchInitialEvent) {
        emit(SubCategoriesLoadingState());
        try {
          var networkstatus = await isNetworkAvailable();
          if (networkstatus) {
            // user controller logic here
            final response =
                await CategoryController.getSubCategories(event.categoryId);
            emit(SubCategoriesLoadedState(
              subCategories: response,
              categoryName: event.categoryName,
              index: event.index,
            ));
          } else {
            emit(SubCategoriesNoInternetState());
          }
        } catch (error) {
          emit(SubCategoriesErrorState(error: error.toString()));
        }
      } else if (event is SubCategoriesSubscribeEvent) {
        emit(SubCategoriesLoadingState());
        try {
          var networkstatus = await isNetworkAvailable();
          if (networkstatus) {
            // user controller logic here

            emit(SubCategoriesSubscribedState());
          } else {
            emit(SubCategoriesNoInternetState());
          }
        } catch (error) {
          emit(SubCategoriesErrorState(error: error.toString()));
        }
      }
    });
  }
}
