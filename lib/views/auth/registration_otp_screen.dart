// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_validators.dart';
import 'package:hobbyzhub/views/auth/login_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/text_fields/otp_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistrationOtpScreen extends StatefulWidget {
  final String email;
  const RegistrationOtpScreen({super.key, required this.email});

  @override
  State<RegistrationOtpScreen> createState() => _RegistrationOtpScreenState();
}

class _RegistrationOtpScreenState extends State<RegistrationOtpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late OtpTimerCubit otpTimerCubit;

  // Blocs
  AuthBloc authBloc = AuthBloc();

  initCubits() {
    otpTimerCubit = context.read<OtpTimerCubit>();
    otpTimerCubit.startOtpIntervals();
  }

  initBlocs() {
    authBloc = context.read<AuthBloc>()
      ..add(AuthEventSendVerificationEmail(email: widget.email));
  }

  @override
  void initState() {
    super.initState();

    initCubits();
    initBlocs();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: BackAppbarWidget(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoadingState) {
            toast("Loading");
          } else if (state is AuthSendVerificationState) {
            toast(state.response.message);
          } else if (state is AuthVerificationState) {
            AppDialogs.otpSuccessDialog(context).then((value) {
              AppNavigator.goToPageWithReplacement(
                context: context,
                screen: LoginScreen(),
              );
            });
          } else if (state is AuthStateFailure) {
            toast(state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      Text('OTP Verification', style: AppTextStyle.headings),
                      30.height,
                      Text(
                          'A 4 digit code has been sent to your email ${widget.email}',
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
                    child: Column(
                      children: [
                        PrimaryButtonWidget(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthEventVerifyEmail(email: widget.email),
                                  );
                            }
                          },
                          caption: 'Verify',
                        ),
                        20.height,
                        Text(
                          'Resend OTP',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.resentOtpTextStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
