import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/notification/notification_screen.dart';
import 'package:hobbyzhub/views/profile/settings/help_center_screen.dart';
import 'package:hobbyzhub/views/profile/settings/privacy_policy_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/two_buttons_appbar.dart';
import 'package:hobbyzhub/views/widgets/images/profile_image_widget.dart';
import 'package:hobbyzhub/views/widgets/list_tile/list_tile_widget.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
          screen: const NotificationScreen(),
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
        break;
      case 5:
        // navigate to about us screen
        break;
      case 6:
        // navigate to log out screen
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const TwoButtonsAppbar(
      //   title: "Settings",
      //   icon: Ionicons.search_outline,
      //   color: AppColors.transparent,
      // ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: AppColors.grey),
            child: const TwoButtonsAppbar(
              title: "Settings",
              icon: Ionicons.search_outline,
              color: AppColors.transparent,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ProfileImageWidget(
                        imageUrl: ImageAssets.userProfileImage,
                        isEditable: false,
                      ),
                      20.height,
                      Text(
                        "Sara Stamp",
                        style: AppTextStyle.normal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.height,
                      const BioTextWidget(
                        bio:
                            "I just love the idea of not being what people expect me to be!",
                      ),
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
                      const ListTileWidget(
                        title: "FAQs",
                        subtitle: "Frequently asked questions",
                        icon: Icons.abc_outlined,
                      ),
                      const ListTileWidget(
                        title: "About us",
                        subtitle: "About hobbyzhub",
                        icon: Ionicons.information_circle_outline,
                      ),
                      // log out widget
                      const ListTileWidget(
                        title: "Log out",
                        subtitle: "",
                        icon: Ionicons.log_out_outline,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
