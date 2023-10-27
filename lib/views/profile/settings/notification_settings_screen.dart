import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  // Booleans
  bool sound = true;
  bool directMessage = false;
  bool friendRequest = true;
  bool mentions = false;

  bool likes = false;
  bool comments = true;
  bool shares = false;

  bool groupInvitations = false;
  bool groupActivities = true;

  bool trendingPosts = false;
  bool popularUsers = true;

  bool appUpdates = false;
  bool newsAndAnnouncements = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "Notification"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notification sound preferences",
                style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
              ),
              10.height,
              Text(
                "Personalize the way you receive notifications by choosing sound or vibration.",
                style: AppTextStyle.normal,
              ),
              // sound or vibration check boxes
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // create a radio buttons
                  Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: sound,
                        fillColor: MaterialStateProperty.all(AppColors.primary),
                        onChanged: (value) {
                          setState(() {
                            sound = value as bool;
                          });
                        },
                      ),
                      Text(
                        "Sound",
                        style: AppTextStyle.normal,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: false,
                        fillColor: MaterialStateProperty.all(AppColors.primary),
                        groupValue: sound,
                        onChanged: (value) {
                          setState(() {
                            sound = value as bool;
                          });
                        },
                      ),
                      Text(
                        "Vibrate",
                        style: AppTextStyle.normal,
                      ),
                    ],
                  ),
                ],
              ),
              20.height,
              CustomExpansionTile(
                title: "General Notifications",
                subtitle:
                    "New messages, friend requests, mentions, activity updates.",
                children: [
                  CustionSwitchListTile(
                    value: directMessage,
                    title: "Direct Messages",
                    subtitle: "Receive notifications for new direct messages.",
                    onChanged: (value) {
                      setState(() {
                        directMessage = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: friendRequest,
                    title: "Friend Requests",
                    subtitle:
                        "Receive notifications when someone sends you a friend request.",
                    onChanged: (value) {
                      setState(() {
                        friendRequest = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: mentions,
                    title: "Mentions",
                    subtitle:
                        "Receive notifications when someone mentions you in a post or comment.",
                    onChanged: (value) {
                      setState(() {
                        mentions = value;
                      });
                    },
                  ),
                ],
              ),
              20.height,
              CustomExpansionTile(
                title: "Post Interactions",
                subtitle: "Likes, comments, shares",
                children: [
                  CustionSwitchListTile(
                    value: likes,
                    title: "Likes",
                    subtitle:
                        "Receive notifications when someone likes your posts.",
                    onChanged: (value) {
                      setState(() {
                        likes = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: comments,
                    title: "Comments",
                    subtitle:
                        "Receive notifications when someone comments on your posts.",
                    onChanged: (value) {
                      setState(() {
                        comments = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: shares,
                    title: "Shares",
                    subtitle:
                        "Receive notifications when someone shares your posts.",
                    onChanged: (value) {
                      setState(() {
                        shares = value;
                      });
                    },
                  ),
                ],
              ),
              20.height,
              CustomExpansionTile(
                title: "Group Related Notifications",
                subtitle: "Group invitations and group activities",
                children: [
                  CustionSwitchListTile(
                    value: groupInvitations,
                    title: "Group Invitations",
                    subtitle:
                        "Receive notifications when you are invited to join a group.",
                    onChanged: (value) {
                      setState(() {
                        groupInvitations = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: groupActivities,
                    title: "Group Activities",
                    subtitle:
                        "Receive notifications about new posts, comments, or events in your joined groups.",
                    onChanged: (value) {
                      setState(() {
                        groupActivities = value;
                      });
                    },
                  ),
                ],
              ),
              20.height,
              CustomExpansionTile(
                title: "Trending and Popular Content",
                subtitle: "Trending posts and popular users",
                children: [
                  CustionSwitchListTile(
                    value: trendingPosts,
                    title: "Trending Posts",
                    subtitle:
                        "Receive notifications for posts that are currently trending or popular among users.",
                    onChanged: (value) {
                      setState(() {
                        trendingPosts = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: popularUsers,
                    title: "Popular Users",
                    subtitle:
                        "Receive notifications about users who are trending or gaining popularity.",
                    onChanged: (value) {
                      setState(() {
                        popularUsers = value;
                      });
                    },
                  ),
                ],
              ),
              20.height,
              CustomExpansionTile(
                title: "App Updates and News",
                subtitle: "App updates, news and announcements",
                children: [
                  CustionSwitchListTile(
                    value: appUpdates,
                    title: "App Updates",
                    subtitle:
                        "Receive notifications about new features, updates, or improvements to the HobbyzHub app.",
                    onChanged: (value) {
                      setState(() {
                        appUpdates = value;
                      });
                    },
                  ),
                  CustionSwitchListTile(
                    value: newsAndAnnouncements,
                    title: "News and Announcements",
                    subtitle:
                        "Receive important news or announcements from the HobbyzHub team.",
                    onChanged: (value) {
                      setState(() {
                        newsAndAnnouncements = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustionSwitchListTile extends StatelessWidget {
  final bool value;
  final String title, subtitle;
  final Function(bool)? onChanged;
  const CustionSwitchListTile({
    Key? key,
    required this.value,
    required this.title,
    required this.subtitle,
    this.onChanged,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
      ),
      subtitle: Text(subtitle, style: AppTextStyle.normal),
      contentPadding: EdgeInsets.zero,
      value: value,
      activeColor: AppColors.primary,
      inactiveThumbColor: AppColors.primary,
      isThreeLine: true,
      // reduce the size of switch
      activeTrackColor: AppColors.grey,
      inactiveTrackColor: AppColors.grey,
      onChanged: onChanged,
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final String title, subtitle;
  final List<Widget> children;
  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        title,
        style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
      ),
      subtitle: Text(subtitle, style: AppTextStyle.normal),
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      shape: InputBorder.none,
      collapsedShape: InputBorder.none,
      children: children,
    );
  }
}
