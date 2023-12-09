import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/create_post/createpost_cubit.dart';
import 'package:hobbyzhub/blocs/delete_post/delete_post_cubit.dart';
import 'package:hobbyzhub/blocs/get_post/get_post_cubit.dart';
import 'package:hobbyzhub/blocs/image_picker/image_picker_bloc.dart';
import 'package:hobbyzhub/blocs/timer_cubit/timer_cubit_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
    BlocProvider<CreatepostCubit>(create: (context) => CreatepostCubit()),
    BlocProvider<DeletePostCubit>(create: (context) => DeletePostCubit()),
    BlocProvider<GetPostCubit>(
        create: (context) => GetPostCubit()..getPostList())
  ];
}
