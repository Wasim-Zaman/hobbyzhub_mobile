// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/profile/followers_following_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/profile_image_widget.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:hobbyzhub/views/widgets/text/text_value_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // profile image
                const ProfileImageWidget(
                  imageUrl: ImageAssets.userProfileImage,
                  isEditable: false,
                ),
                // Name
                Text("Sara Stamp", style: AppTextStyle.subHeading),
                20.height,
                // Bio
                const BioTextWidget(
                  bio:
                      'I just love the idea of not being what people expect me to be!',
                ),
                20.height,
                // Posts, following and followers in one row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <TextValueWidget>[
                    const TextValueWidget(text: "85", value: "Posts"),
                    TextValueWidget(
                      text: "870",
                      value: "Following",
                      onTap: () {
                        AppNavigator.goToPage(
                          context: context,
                          screen: const FollowersFollowingScreen(index: 1),
                        );
                      },
                    ),
                    TextValueWidget(
                      text: "15k",
                      value: "Followers",
                      onTap: () {
                        AppNavigator.goToPage(
                          context: context,
                          screen: const FollowersFollowingScreen(index: 0),
                        );
                      },
                    ),
                  ],
                ),
                20.height,
                const ProfileWidgets(),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileWidgets extends StatelessWidget {
  const ProfileWidgets({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: PrimaryButtonWidget(
            caption: "Edit Profile",
            onPressed: () {},
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Ionicons.settings_outline,
                color: AppColors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
