part of "categories_bloc.dart";

abstract class CategoriesEvent {}

class CategoriesFetchInitialEvent extends CategoriesEvent {}

class CategoriesFetchMoreEvent extends CategoriesEvent {
  final int page, paginatedBy;
  CategoriesFetchMoreEvent({required this.page, required this.paginatedBy});
}

class CategoriesSeachEvent extends CategoriesEvent {
  final String slug;
  CategoriesSeachEvent({required this.slug});
}

abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final ApiResponse categories;
  CategoriesLoadedState({required this.categories});
}

class CategoriesErrorState extends CategoriesState {
  final String error;
  CategoriesErrorState({required this.error});
}

class CategoriesEmptyState extends CategoriesState {}

class CategoriesNotFoundState extends CategoriesState {}

class CategoriesNoInternetState extends CategoriesState {}
