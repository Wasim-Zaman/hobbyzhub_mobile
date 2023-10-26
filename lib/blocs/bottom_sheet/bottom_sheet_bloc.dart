import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BottomSheetEvent {}

class BottomSheetDragEvent extends BottomSheetEvent {
  final double offset;
  BottomSheetDragEvent(this.offset);
}

abstract class BottomSheetState {}

class BottomSheetInitial extends BottomSheetState {}

class BottomSheetDragState extends BottomSheetState {
  final double offset;
  BottomSheetDragState(this.offset);
}

// Bloc
class BottomSheetBloc extends Bloc<BottomSheetEvent, BottomSheetState> {
  BottomSheetBloc() : super(BottomSheetInitial()) {
    on<BottomSheetDragEvent>((event, emit) {
      emit(BottomSheetDragState(event.offset));
    });
  }
}
