// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/auth/recovery_password.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

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

  @override
  void initState() {
    super.initState();

    initCubits();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.primary;

    const borderColor = AppColors.borderGrey;

    final defaultPinTheme = PinTheme(
      width: 70,
      height: 80,
      textStyle: const TextStyle(
        fontSize: 22,
        color: AppColors.darkGrey,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: BackAppbarWidget(),
      body: Padding(
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
                    'Put the OTP number below sent to your number +3333-123123123',
                    style: AppTextStyle.subHeading),
                50.height,
                Center(
                  child: Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      showCursor: false,
                      defaultPinTheme: defaultPinTheme,
                      length: 4,
                      pinAnimationType: PinAnimationType.scale,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 50,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme,
                      submittedPinTheme: defaultPinTheme,
                      errorPinTheme: defaultPinTheme,
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
                    onPressed: () {
                      AppNavigator.goToPage(
                        context: context,
                        screen: RecoveryPasswordScreen(),
                      );
                    },
                    caption: 'Send OTP',
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
  }
}
