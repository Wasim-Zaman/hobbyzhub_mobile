import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/delete_fcm_token/delete_fcm_token_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/user/user_profile_model.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/auth/login_screen.dart';
import 'package:hobbyzhub/views/profile/settings/about_us_screen.dart';
import 'package:hobbyzhub/views/profile/settings/faq_screen.dart';
import 'package:hobbyzhub/views/profile/settings/help_center_screen.dart';
import 'package:hobbyzhub/views/profile/settings/notification_settings_screen.dart';
import 'package:hobbyzhub/views/profile/settings/privacy_policy_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/appbars/two_buttons_appbar.dart';
import 'package:hobbyzhub/views/widgets/images/profile_image_widget.dart';
import 'package:hobbyzhub/views/widgets/list_tile/list_tile_widget.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingsScreen extends StatefulWidget {
  final UserProfileModel user;
  const SettingsScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void navigate(int page) {
    switch (page) {
      case 1:
        // navigate to notification screen
        AppNavigator.goToPage(
          context: context,
          screen: const NotificationSettingsScreen(),
        );
        break;
      case 2:
        // navigate to privacy policy screen
        AppNavigator.goToPage(
          context: context,
          screen: const PrivacyPolicyScreen(),
        );
        break;
      case 3:
        // navigate to help center screen
        AppNavigator.goToPage(
          context: context,
          screen: const HelpCenterScreen(),
        );
        break;
      case 4:
        // navigate to FAQs screen
        AppNavigator.goToPage(context: context, screen: const FaqScreen());
        break;
      case 5:
        AppNavigator.goToPage(context: context, screen: const AboutUsScreen());
        break;
      case 6:
        // navigate to log out screen
        AppDialogs.logoutDialog(context, logout: logout);
        break;
    }
  }

  void logout() async {
    context.read<DeleteFcmTokenCubit>().unRegisterFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeleteFcmTokenCubit, DeleteFcmTokenState>(
      builder: (context, state) {
        if (state is DeleteFcmTokenSuccess) {
          UserSecureStorage.logout().then((value) {
            AppDialogs.closeDialog(context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          });
        }
        return Scaffold(
          backgroundColor: AppColors.grey,
          appBar: const BackAppbarWidget(
            title: "Settings",
            color: AppColors.transparent,
          ),
          body: SafeArea(
            child: Container(
              height: context.height(),
              margin: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.elliptical(1000, 200),
                  topRight: Radius.elliptical(1000, 200),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileImageWidget(
                        imageUrl: widget.user.data.profileImage.toString(),
                        isEditable: true,
                      ),
                      20.height,
                      Text(
                        widget.user.data.fullName,
                        style: AppTextStyle.normal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.height,
                      BioTextWidget(bio: widget.user.data.bio),
                      20.height,
                      ListTileWidget(
                        title: "Notification",
                        subtitle: "Messages, groups and others",
                        icon: Ionicons.notifications_outline,
                        onTap: () => navigate(1),
                      ),
                      // privacy and policy list tile widget
                      ListTileWidget(
                        title: "Privacy Policy",
                        subtitle: "Hobbyzhub’s privacy policies",
                        icon: Ionicons.shield_checkmark_outline,
                        onTap: () => navigate(2),
                      ),
                      // help center list tile widget
                      ListTileWidget(
                        title: "Help Center",
                        subtitle: "Help center, contact us",
                        icon: Ionicons.help_circle_outline,
                        onTap: () => navigate(3),
                      ),
                      // FAQs list tile widget
                      ListTileWidget(
                        title: "FAQs",
                        subtitle: "Frequently asked questions",
                        icon: Icons.abc_outlined,
                        onTap: () => navigate(4),
                      ),
                      ListTileWidget(
                        title: "About us",
                        subtitle: "About hobbyzhub",
                        icon: Ionicons.information_circle_outline,
                        onTap: () => navigate(5),
                      ),
                      // log out widget
                      ListTileWidget(
                          title: "Log out",
                          subtitle: "",
                          icon: Ionicons.log_out_outline,
                          onTap: () {
                            navigate(6);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: context.height() * 0.2,
          decoration: const BoxDecoration(
            color: AppColors.grey,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(70),
            ),
          ),
        ),
        const TwoButtonsAppbar(
          title: "Settings",
          icon: Ionicons.search_outline,
          color: Colors.transparent,
        )
      ],
    );
  }
}
