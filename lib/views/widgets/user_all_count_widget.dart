import 'package:flutter/material.dart';
import 'package:hobbyzhub/controllers/follower/f_and_f_controller.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/profile/followers_following_screen.dart';
import 'package:hobbyzhub/views/profile/third_person_followers_following_screen.dart';
import 'package:hobbyzhub/views/widgets/text/text_value_widget.dart';

class UserAllCountWidget extends StatefulWidget {
  final bool? isThirdPerson;
  final String? userId;
  const UserAllCountWidget({Key? key, this.isThirdPerson, this.userId})
      : super(key: key);

  @override
  State<UserAllCountWidget> createState() => _UserAllCountWidgetState();
}

class _UserAllCountWidgetState extends State<UserAllCountWidget> {
  followersClick() {
    AppNavigator.goToPage(
      context: context,
      screen: widget.isThirdPerson != null
          ? const ThirdPersonFollowersFollowingScreen(index: 0)
          : const FollowersFollowingScreen(index: 0),
    );
  }

  followingsClick() {
    AppNavigator.goToPage(
      context: context,
      screen: widget.isThirdPerson != null
          ? const ThirdPersonFollowersFollowingScreen(index: 1)
          : const FollowersFollowingScreen(index: 1),
    );
  }

  postsClick() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FAndFController.getCount(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // add shimmers
              Container(
                width: 50,
                height: 20,
                color: AppColors.grey,
              ),
              Container(
                width: 50,
                height: 20,
                color: AppColors.grey,
              ),
              Container(
                width: 50,
                height: 20,
                color: AppColors.grey,
              ),
            ],
          );
        }
        final snap = snapshot.data;
        final posts = snap!['postCount'].toString();
        final followings = snap['followingsCount'].toString();
        final followers = snap['followersCount'].toString();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <TextValueWidget>[
            TextValueWidget(
              text: posts,
              value: "Posts",
            ),
            TextValueWidget(
              text: followings,
              value: "Following",
              onTap: () {
                AppNavigator.goToPage(
                    context: context,
                    screen: const ThirdPersonFollowersFollowingScreen(
                      index: 1,
                    ));
              },
            ),
            TextValueWidget(
              text: followers,
              value: "Followers",
              onTap: () {
                AppNavigator.goToPage(
                  context: context,
                  screen: const ThirdPersonFollowersFollowingScreen(
                    index: 0,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}