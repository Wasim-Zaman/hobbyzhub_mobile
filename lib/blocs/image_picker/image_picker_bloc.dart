import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/utils/media_utils.dart';

part 'image_picker_events_states.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitialState()) {
    on<ImagePickerPickImageEvent>((event, emit) async {
      try {
        final image = await MediaUtils.pickImage();
        emit(ImagePickerPickedImageState(image: image));
      } catch (e) {
        emit(ImagePickerFailureState(message: e.toString()));
      }
    });
  }
}
