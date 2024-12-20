import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hobbyzhub/controllers/setting/setting_controller.dart';
import 'package:meta/meta.dart';

part 'help_center_state.dart';

class HelpCenterCubit extends Cubit<HelpCenterState> {
  HelpCenterCubit() : super(HelpCenterInitial());

  SettingController settingController = SettingController();

  helpCenter(fullName, feedBack) async {
    emit(HelpCenterLoading());
    try {
      var helpRequestBody = {"message": feedBack, "fullName": fullName};
      print(helpRequestBody);
      var response =
          await settingController.submitHelpCenterRequest(helpRequestBody);

      if (response.statusCode == 201) {
        emit(HelpCenterSuccess());
      } else {
        emit(HelpCenterFailed());
      }
    } on SocketException {
      emit(HelpCenterInternetError());
    } catch (e) {
      emit(HelpCenterFailed());
    }
  }
}
