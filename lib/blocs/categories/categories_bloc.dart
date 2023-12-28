import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/constants/app_config.dart';
import 'package:hobbyzhub/controllers/category/category_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:nb_utils/nb_utils.dart';

part 'categories_events_states.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitialState()) {
    on<CategoriesEvent>((event, emit) async {
      // Fetch initial categories
      if (event is CategoriesFetchInitialEvent) {
        emit(CategoriesLoadingState());
        try {
          var networkstatus = await isNetworkAvailable();
          if (networkstatus) {
            // user controller logic here
            int page = AppConfig.pageOne;
            int pageSize = AppConfig.categoriesPageSize;
            final categories = await CategoryController.getAllCategories(
              page,
              pageSize,
            );
            if (categories.data.isEmpty) {
              emit(CategoriesEmptyState());
            } else {
              emit(CategoriesLoadedState(categories: categories));
            }
          } else {
            emit(CategoriesNoInternetState());
          }
        } catch (error) {
          emit(CategoriesErrorState(error: error.toString()));
        }
      }

      // Fetch more categories
      if (event is CategoriesFetchMoreEvent) {
        try {
          var networkstatus = await isNetworkAvailable();
          if (networkstatus) {
            // user controller logic here
          } else {
            emit(CategoriesNoInternetState());
          }
        } catch (error) {
          emit(CategoriesErrorState(error: error.toString()));
        }
      }
    });
  }
}