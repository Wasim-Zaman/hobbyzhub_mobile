import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/bloc_provider.dart';
import 'package:hobbyzhub/global/themes/app_theme.dart';
import 'package:hobbyzhub/views/onboarding/onboarding_screen.dart';
import 'package:hobbyzhub/views/splash_screen/splash_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialize();
  timeago.setLocaleMessages('fr', timeago.EnMessages());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: ScreenUtilInit(
          designSize: Size(width, height),
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                hideKeyboard(context);
              },
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'HobbyzHub',
                theme: AppTheme.light,
                navigatorKey: navigatorKey,
                home: const SplashScreen(),
              ),
            );
          }),
    );
  }
}
