import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/bloc_provider.dart';
import 'package:hobbyzhub/global/themes/app_theme.dart';
import 'package:hobbyzhub/models/auth/finish_account_model.dart';
import 'package:hobbyzhub/views/categories/main_categories_screen.dart';
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
              home: MainCategoriesScreen(
                model: FinishAccountModel(
                  bio: "Flutter Dev",
                  birthdate: "03-05-2001",
                  email: "wasimxaman13@gmail.com",
                  fullName: "Wasim Zaman",
                  gender: "Male",
                  userId: "2b797185fb19",
                  profileImage:
                      "https://stoneagebucket.s3.amazonaws.com/1704092669100_image.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240101T070429Z&X-Amz-SignedHeaders=host&X-Amz-Expires=604800&X-Amz-Credential=AKIAQUYSNZ3OI32HJQNU%2F20240101%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=46dff2bfabb0d3cdc87e520a6f9b918bb28c3733a9b8670b06d86f355b77b1df",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
