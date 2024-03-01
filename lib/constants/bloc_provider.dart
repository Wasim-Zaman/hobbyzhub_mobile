import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/auth/auth_bloc.dart';
import 'package:hobbyzhub/blocs/chat/chat_bloc.dart';
import 'package:hobbyzhub/blocs/create_conversation/create_conversation_cubit.dart';
import 'package:hobbyzhub/blocs/create_post/createpost_cubit.dart';
import 'package:hobbyzhub/blocs/create_story/create_story_cubit.dart';
import 'package:hobbyzhub/blocs/delete_fcm_token/delete_fcm_token_cubit.dart';
import 'package:hobbyzhub/blocs/delete_post/delete_post_cubit.dart';
import 'package:hobbyzhub/blocs/fcm_token/fcm_token_cubit.dart';
import 'package:hobbyzhub/blocs/follower_following/f_and_f_bloc.dart';
import 'package:hobbyzhub/blocs/get_post/get_post_cubit.dart';
import 'package:hobbyzhub/blocs/get_stories/get_stories_cubit.dart';
import 'package:hobbyzhub/blocs/get_user/get_users_cubit.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/blocs/help_center/help_center_cubit.dart';
import 'package:hobbyzhub/blocs/image_picker/image_picker_bloc.dart';
import 'package:hobbyzhub/blocs/like_post/likes_cubit.dart';
import 'package:hobbyzhub/blocs/specific_post/specific_post_cubit.dart';
import 'package:hobbyzhub/blocs/third_user_post/third_user_post_cubit.dart';
import 'package:hobbyzhub/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:hobbyzhub/blocs/unlike_post/unlike_post_cubit.dart';
import 'package:hobbyzhub/blocs/update_profile/update_profile_cubit.dart';
import 'package:hobbyzhub/blocs/user/user_bloc.dart';
import 'package:hobbyzhub/blocs/user_posts/user_post_cubit.dart';
import 'package:hobbyzhub/blocs/user_profile/profile_cubit.dart';
import 'package:hobbyzhub/blocs/write_comment/write_comment_cubit.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<OtpTimerCubit>(create: (context) => OtpTimerCubit()),
    BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
    BlocProvider<CreatepostCubit>(create: (context) => CreatepostCubit()),
    BlocProvider<DeletePostCubit>(create: (context) => DeletePostCubit()),
    BlocProvider<SpecificPostCubit>(create: (context) => SpecificPostCubit()),
    BlocProvider<WriteCommentCubit>(create: (context) => WriteCommentCubit()),
    BlocProvider<LikesCubit>(create: (context) => LikesCubit()),
    BlocProvider<HelpCenterCubit>(create: (context) => HelpCenterCubit()),
    BlocProvider<ImagePickerBloc>(create: (context) => ImagePickerBloc()),
    BlocProvider<GetPostCubit>(
        create: (context) => GetPostCubit()..getPostList()),
    BlocProvider<FAndFBloc>(create: (context) => FAndFBloc()),
    BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
    BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
    BlocProvider<ThirdUserCubit>(create: (context) => ThirdUserCubit()),
    BlocProvider<UserPostCubit>(create: (context) => UserPostCubit()),
    BlocProvider<UserBloc>(create: (context) => UserBloc()),
    BlocProvider<ChatBloc>(create: (context) => ChatBloc()),
    BlocProvider<UpdateProfileCubit>(create: (context) => UpdateProfileCubit()),
    BlocProvider<FcmTokenCubit>(create: (context) => FcmTokenCubit()),
    BlocProvider<UnlikePostCubit>(create: (context) => UnlikePostCubit()),
    BlocProvider<GetUsersCubit>(create: (context) => GetUsersCubit()),
    BlocProvider<CreateStoryCubit>(create: (context) => CreateStoryCubit()),
    BlocProvider<GetStoriesCubit>(create: (context) => GetStoriesCubit()),
    BlocProvider<CreateConversationCubit>(
        create: (context) => CreateConversationCubit()),
    BlocProvider<DeleteFcmTokenCubit>(
        create: (context) => DeleteFcmTokenCubit()),
    BlocProvider<GroupBloc>(create: (context) => GroupBloc()),
  ];
}
