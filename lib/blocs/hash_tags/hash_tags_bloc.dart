// Events
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HashTagsEvent {}

class HashTagsEventHandler extends HashTagsEvent {
  final List<String> tags;
  HashTagsEventHandler(this.tags);
}

// States
abstract class HashTagsState {}

class HashTagsStateInitial extends HashTagsState {}

class HashTagsStateLoading extends HashTagsState {}

class HashTagsStateSuccess extends HashTagsState {
  final List<String> tags;
  HashTagsStateSuccess(this.tags);
}

class HashTagsBloc extends Bloc<HashTagsEvent, HashTagsState> {
  HashTagsBloc() : super(HashTagsStateInitial()) {
    on<HashTagsEventHandler>((event, emit) async {
      emit(HashTagsStateLoading());
      final HashTagsEventHandler fetchEvent = event;
      final List<String> tags = fetchEvent.tags;
      emit(HashTagsStateSuccess(tags));
    });
  }
}
