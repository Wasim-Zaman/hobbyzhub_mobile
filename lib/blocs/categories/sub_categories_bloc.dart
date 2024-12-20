import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/controllers/category/category_controller.dart';
import 'package:hobbyzhub/models/api_response.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
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
        try {
          var networkstatus = await isNetworkAvailable();
          if (networkstatus) {
            // user controller logic here
            final response =
                await CategoryController.subscribeUserToSubCategory(
              event.subCategoryId,
              event.finishAccountModel,
            );
            emit(SubCategoriesSubscribedState(response: response));
          } else {
            emit(SubCategoriesNoInternetState());
          }
        } catch (error) {
          emit(
            SubCategoriesUnsubscribedState(subCategoryId: event.subCategoryId),
          );
        }
      }
    });
  }
}
