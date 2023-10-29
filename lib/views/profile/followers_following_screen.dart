import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/two_buttons_appbar.dart';
import 'package:ionicons/ionicons.dart';

class FollowersFollowingScreen extends StatelessWidget {
  const FollowersFollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: TwoButtonsAppbar(
          title: "Sara Stamp",
          icon: Ionicons.search_outline,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Followers'), // First tab
              Tab(text: 'Followings'), // Second tab
            ],
          ),
          size: 100,
        ),
        body: TabBarView(
          children: [
            FollowersScreen(), // Content for the first tab
            FollowingScreen(), // Content for the second tab
          ],
        ),
      ),
    );
  }
}

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FollowerFollowingListTile(
          activeStatus: true,
          imageUrl: "",
          lastSeen: "Active 2m ago",
          name: "John Doe",
          isFollowed: true,
        ),
        FollowerFollowingListTile(
          activeStatus: true,
          imageUrl: "",
          lastSeen: "Active 2m ago",
          name: "John Doe",
          isFollowed: false,
        ),
        FollowerFollowingListTile(
          activeStatus: false,
          imageUrl: "",
          lastSeen: "Active 2m ago",
          name: "John Doe",
          isFollowed: true,
        ),
      ],
    );
  }
}

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Followings',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class FollowerFollowingListTile extends StatelessWidget {
  final String imageUrl;
  final bool activeStatus, isFollowed;
  final String name, lastSeen;
  const FollowerFollowingListTile({
    Key? key,
    required this.imageUrl,
    required this.activeStatus,
    required this.name,
    required this.lastSeen,
    required this.isFollowed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          Image.asset(ImageAssets.userProfileImage),
          activeStatus
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                )
              : Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
                    ),
                  ),
                ),
        ],
      ),
      title: Text(name),
      subtitle: Text(lastSeen),
      trailing: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowed ? AppColors.grey : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          foregroundColor: AppColors.white,
        ),
        child: Text(
          isFollowed ? "Following" : "follow",
          style: AppTextStyle.button.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
