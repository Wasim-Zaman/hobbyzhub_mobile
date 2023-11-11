// Events
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class MultiImagePickerEvent {}

class MultiImagePickerEventPickFiles extends MultiImagePickerEvent {
  MultiImagePickerEventPickFiles(this.picker);

  final ImagePicker picker;
}

class MultiImagePickerEventClear extends MultiImagePickerEvent {}

// States
abstract class MultiImagePickerState {}

class MultiImagePickerStateInitial extends MultiImagePickerState {}

class MultiImagePickerStateLoading extends MultiImagePickerState {}

class MultiImagePickerStatePickedFiles extends MultiImagePickerState {
  MultiImagePickerStatePickedFiles(this.pickedFiles);

  final List<XFile> pickedFiles;
}

class MultiImagePickerStateClear extends MultiImagePickerState {}

// Bloc
class MultiImagePickerBloc
    extends Bloc<MultiImagePickerEvent, MultiImagePickerState> {
  MultiImagePickerBloc() : super(MultiImagePickerStateInitial()) {
    on<MultiImagePickerEventPickFiles>((event, emit) async {
      emit(MultiImagePickerStateLoading());
      final MultiImagePickerEventPickFiles pickFilesEvent = event;
      final ImagePicker picker = pickFilesEvent.picker;
      final List<XFile> pickedFiles = await picker.pickMultiImage();
      emit(MultiImagePickerStatePickedFiles(pickedFiles));
    });

    on<MultiImagePickerEventClear>((event, emit) async {
      emit(MultiImagePickerStateClear());
    });
  }
}
