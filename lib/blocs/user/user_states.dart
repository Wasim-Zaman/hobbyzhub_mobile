part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserSearchByNameSuccess extends UserState {
  final List<User> users;
  UserSearchByNameSuccess({required this.users});
}

class UserSearchByNameMoreSuccess extends UserState {
  final List<User> users;
  UserSearchByNameMoreSuccess({required this.users});
}

class UserSearchByNameFailure extends UserState {
  final String message;
  UserSearchByNameFailure({required this.message});
}

class UserSearchByNameLoading extends UserState {}

class UserSearchByNameEmpty extends UserState {}
