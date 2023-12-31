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
  SubCategoriesSubscribeEvent({required this.subCategoryId});
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

class SubCategoriesSubscribedState extends SubCategoriesState {}
