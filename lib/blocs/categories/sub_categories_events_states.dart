part of 'sub_categories_bloc.dart';

abstract class SubCategoriesEvent {}

class SubCategoriesFetchInitialEvent extends SubCategoriesEvent {
  final String categoryId;
  final int index;
  SubCategoriesFetchInitialEvent({
    required this.categoryId,
    required this.index,
  });
}

abstract class SubCategoriesState {}

class SubCategoriesInitialState extends SubCategoriesState {}

class SubCategoriesLoadingState extends SubCategoriesState {}

class SubCategoriesLoadedState extends SubCategoriesState {
  final ApiResponse subCategories;
  final int index;
  SubCategoriesLoadedState({required this.subCategories, required this.index});
}

class SubCategoriesErrorState extends SubCategoriesState {
  final String error;
  SubCategoriesErrorState({required this.error});
}

class SubCategoriesNoInternetState extends SubCategoriesState {}
