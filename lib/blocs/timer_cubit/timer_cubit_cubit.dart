import 'dart:async';

import 'package:bloc/bloc.dart';

part 'timer_cubit_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  int i = 30;
  late Timer timer;

  OtpTimerCubit() : super(OtpTimerInitial());

  startOtpIntervals() async {
    emit(OtpTimerInitial());
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(OtpTimerRunning(secondsValue: i));
      i--;
      if (i == 0) {
        timer.cancel();
        i = 10;
        emit(const OtpTimerStoppedShowButton());
      }
    });
  }

  pauseTimer() {
    timer.cancel();
    emit(OtpTimerInitial());
  }

  stopTimer() {
    timer.cancel();
    i = 10;

    emit(const OtpTimerStoppedShowButton());
  }
}
