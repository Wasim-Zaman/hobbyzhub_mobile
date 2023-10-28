// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/profile_image_widget.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:hobbyzhub/views/widgets/text/text_value_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

enum Page { posts, groups }

class ThirdPersonProfileScreen extends StatefulWidget {
  const ThirdPersonProfileScreen({Key? key}) : super(key: key);

  @override
  _ThirdPersonProfileScreenState createState() =>
      _ThirdPersonProfileScreenState();
}

class _ThirdPersonProfileScreenState extends State<ThirdPersonProfileScreen> {
  // posts and similar groups post controller
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <TextValueWidget>[
                    TextValueWidget(text: "85", value: "Posts"),
                    TextValueWidget(text: "870", value: "Following"),
                    TextValueWidget(text: "15k", value: "Followers"),
                  ],
                ),
                20.height,
                const NonFollowedPersonWidget(),
                20.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FollowedPersonWidget extends StatelessWidget {
  const FollowedPersonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: PrimaryButtonWidget(
            caption: "Following",
            color: AppColors.grey,
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
                Ionicons.chatbox_ellipses_outline,
                color: AppColors.white,
              ),
            ),
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
                // three dots icon
                Ionicons.ellipsis_horizontal,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NonFollowedPersonWidget extends StatelessWidget {
  const NonFollowedPersonWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: PrimaryButtonWidget(
            caption: "Follow",
            onPressed: () {},
            icon: Ionicons.add,
          ),
        ),
        Expanded(
            flex: 1,
            child: PopupMenuButton(
              color: AppColors.white,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: ListTile(
                    // i like icon
                    leading: const Icon(
                      Ionicons.information_circle_outline,
                      color: AppColors.dangerColor,
                    ),
                    title: Text(
                      "Report",
                      style: AppTextStyle.normal
                          .copyWith(color: AppColors.dangerColor),
                    ),
                  ),
                ),
                // report
                PopupMenuItem(
                  child: ListTile(
                    // i like icon
                    leading: const Icon(Icons.block_outlined),
                    title: Text(
                      "Block",
                      style: AppTextStyle.normal,
                    ),
                  ),
                ),
                // share this profile
                PopupMenuItem(
                  child: ListTile(
                    // i like icon
                    leading: const Icon(Icons.share_outlined),
                    title: Text(
                      "Share this profile",
                      style: AppTextStyle.normal,
                    ),
                  ),
                ),
                // Copy profile URL
                PopupMenuItem(
                  child: ListTile(
                    // i like icon
                    leading: const Icon(Icons.copy_outlined),
                    title: Text(
                      "Copy profile URL",
                      style: AppTextStyle.normal,
                    ),
                  ),
                ),
              ],
              child: Container(
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  // three dots icon
                  Ionicons.ellipsis_horizontal,
                  color: AppColors.white,
                ),
              ),
            )),
      ],
    );
  }
}
