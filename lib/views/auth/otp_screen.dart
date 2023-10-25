// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_toast.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/otp_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late OtpTimerCubit otpTimerCubit;

  initCubits() {
    otpTimerCubit = context.read<OtpTimerCubit>();
    otpTimerCubit.startOtpIntervals();
  }

  initBlocs() {
    context.read<AuthBloc>().add(
          AuthEventSendVerificationForPasswordReset(email: widget.email),
        );
  }

  @override
  void initState() {
    initCubits();
    initBlocs();

    super.initState();
  }

  void verifyOtp() {
    if (formKey.currentState!.validate()) {}
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    UserSecureStorage.deleteOtp();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbarWidget(),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.height,
                  Text('OTP', style: AppTextStyle.headings),
                  30.height,
                  Text(
                      'Put the OTP number below sent to your email ${widget.email}',
                      style: AppTextStyle.subHeading),
                  50.height,
                  Center(
                    child: Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: OtpWidget(
                        pinController: pinController,
                        focusNode: focusNode,
                        validator: AppValidators.otp,
                      ),
                    ),
                  ),
                  30.height,
                  BlocBuilder<OtpTimerCubit, OtpTimerState>(
                    builder: (context, state) {
                      if (state is OtpTimerRunning) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Code send in ',
                              style: AppTextStyle.codeTextStyle,
                            ),
                            Text('${state.secondsValue} ',
                                style: AppTextStyle.codeTextStyle),
                            Text(
                              'seconds',
                              style: AppTextStyle.codeTextStyle,
                            ),
                            10.width,
                          ],
                        );
                      }
                      if (state is OtpTimerInitial) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sending... ',
                              style: AppTextStyle.codeTextStyle,
                            ),
                            10.width,
                          ],
                        );
                      } else if (state is OtpTimerStoppedShowButton) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                otpTimerCubit.startOtpIntervals();
                                initBlocs();
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom: 1.h,
                                ),
                                child: Text(
                                  'Click here to resend code',
                                  style: AppTextStyle.codeTextStyle,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  20.height,
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.w),
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoadingState) {
                      AppDialogs.loadingDialog(context);
                    } else if (state
                        is AuthSendVerificationForPasswordResetState) {
                      AppDialogs.closeDialog(context);
                      AppToast.normal(state.response.message);
                    } else if (state is AuthStateFailure) {
                      AppDialogs.closeDialog(context);
                      AppToast.danger(state.message);
                    } else {
                      AppDialogs.closeDialog(context);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        PrimaryButtonWidget(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          onPressed: verifyOtp,
                          caption: 'Verify',
                        ),
                        20.height,
                        BlocBuilder<OtpTimerCubit, OtpTimerState>(
                          builder: (context, st) => TextButton(
                            onPressed: () {
                              otpTimerCubit.startOtpIntervals();
                              initBlocs();
                            },
                            child: Text(
                              'Resend OTP',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.resentOtpTextStyle,
                            ),
                          ).visible(
                            st is OtpTimerStoppedShowButton == true,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
