part of 'user_bloc.dart';

abstract class UserEvent {}

class UserSearchByNameEvent extends UserEvent {
  final String slug;
  final int page, pageSize;
  UserSearchByNameEvent({
    required this.slug,
    required this.page,
    required this.pageSize,
  });
}

class UserSearchByNameMoreEvent extends UserEvent {
  final String slug;
  final int page, pageSize;
  UserSearchByNameMoreEvent({
    required this.slug,
    required this.page,
    required this.pageSize,
  });
}
