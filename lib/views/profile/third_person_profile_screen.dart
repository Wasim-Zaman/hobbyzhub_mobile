// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class ThirdPersonProfileScreen extends StatefulWidget {
  const ThirdPersonProfileScreen({Key? key}) : super(key: key);

  @override
  _ThirdPersonProfileScreenState createState() =>
      _ThirdPersonProfileScreenState();
}

class _ThirdPersonProfileScreenState extends State<ThirdPersonProfileScreen> {
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
                Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: AppColors.borderGrey,
                    ),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/userprofile.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Name
                Text("Sara Stamp", style: AppTextStyle.subHeading),
                20.height,
                // Bio
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'I just love the idea of not being what people expect me to be!',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normal,
                  ),
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
                Row(
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
                      child: GestureDetector(
                        onTap: () {
                          // Display a small menu after we click on three dots.
                        },
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
                ),
                20.height,
                Row(
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
                ).visible(false),
                20.height,
                // Create two tabs for posts and common groups
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextValueWidget extends StatelessWidget {
  final String text, value;
  const TextValueWidget({Key? key, required this.text, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyle.normal),
        Text(text, style: AppTextStyle.normal),
      ],
    );
  }
}
