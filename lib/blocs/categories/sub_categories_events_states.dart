part of 'sub_categories_bloc.dart';

abstract class SubCategoriesEvent {}

class SubCategoriesFetchInitialEvent extends SubCategoriesEvent {
  final String categoryId;
  final String categoryName;
  final int index;
  SubCategoriesFetchInitialEvent({
    required this.categoryId,
    required this.categoryName,
    required this.index,
  });
}

// subscribe user to a sub category
class SubCategoriesSubscribeEvent extends SubCategoriesEvent {
  final String subCategoryId;
  final FinishAccountModel finishAccountModel;
  SubCategoriesSubscribeEvent(
      {required this.subCategoryId, required this.finishAccountModel});
}

abstract class SubCategoriesState {}

class SubCategoriesInitialState extends SubCategoriesState {}

class SubCategoriesLoadingState extends SubCategoriesState {}

class SubCategoriesLoadedState extends SubCategoriesState {
  final ApiResponse subCategories;
  final String categoryName;
  final int index;
  SubCategoriesLoadedState({
    required this.subCategories,
    required this.categoryName,
    required this.index,
  });
}

class SubCategoriesErrorState extends SubCategoriesState {
  final String error;
  SubCategoriesErrorState({required this.error});
}

class SubCategoriesNoInternetState extends SubCategoriesState {}

class SubCategoriesSubscribedState extends SubCategoriesState {
  final ApiResponse response;
  SubCategoriesSubscribedState({required this.response});
}

class SubCategoriesUnsubscribedState extends SubCategoriesState {
  final String subCategoryId;
  SubCategoriesUnsubscribedState({required this.subCategoryId});
}
