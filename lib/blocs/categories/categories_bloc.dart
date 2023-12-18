import 'package:flutter_bloc/flutter_bloc.dart';
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
