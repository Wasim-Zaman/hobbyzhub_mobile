import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_toast.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/auth/recovery_password.dart';
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
  // controllers
  final pinController = TextEditingController();

  // focus nodes
  final pinFocusNode = FocusNode();

  // form key
  final formKey = GlobalKey<FormState>();

  // blocs and cubits
  late OtpTimerCubit otpTimerCubit;
  AuthBloc authBloc = AuthBloc();

  initCubits() {
    otpTimerCubit = context.read<OtpTimerCubit>();
    otpTimerCubit.startOtpIntervals();
  }

  verifyOtpBloc() {
    authBloc = authBloc
      ..add(AuthEventVerifyOtp(
        email: widget.email,
        otp: pinController.text.trim(),
      ));
  }

  resendOtp() {
    authBloc = authBloc
      ..add(AuthEventSendVerificationForPasswordReset(
        email: widget.email,
      ));
  }

  @override
  void initState() {
    initCubits();
    super.initState();
  }

  void verifyOtp() {
    if (formKey.currentState!.validate()) {
      verifyOtpBloc();
    }
  }

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
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
                        focusNode: pinFocusNode,
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
                                resendOtp();
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
                  bloc: authBloc,
                  listener: (context, state) {
                    if (state is AuthLoadingState) {
                      AppDialogs.loadingDialog(context);
                    } else if (state is AuthVerifyOtpState) {
                      AppDialogs.closeDialog(context);
                      AppToast.normal(state.response.message);
                      AppNavigator.goToPage(
                        context: context,
                        screen: RecoveryPasswordScreen(email: widget.email),
                      );
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
                              resendOtp();
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
