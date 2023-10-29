import 'package:flutter/material.dart';
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
    return const Center(
      child: Text(
        'Followers',
        style: TextStyle(fontSize: 20),
      ),
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
