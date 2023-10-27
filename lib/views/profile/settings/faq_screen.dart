import 'package:flutter/material.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "FAQs"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              10.height,
              const ExpansionTileWidget(
                title: "How do I sign up for HobbyzHub?",
                children:
                    "To sign up for HobbyzHub, simply download the mobile app from the App Store or Google Play Store. Once installed, follow the on-screen instructions to create your account.",
              ),
              10.height,
              const ExpansionTileWidget(
                title: "How can I find people with similar hobbies?",
                children:
                    "HobbyzHub makes it easy to connect with others who share your interests. Simply use the search feature or browse through hobby categories to find like-minded individuals. You can also join hobby-specific groups to meet fellow enthusiasts.",
              ),
              10.height,
              const ExpansionTileWidget(
                title: "Is HobbyzHub available in multiple languages?",
                children:
                    "Currently, HobbyzHub is available in English, but we are actively working on adding support for additional languages to make the app accessible to a wider user base.",
              ),
              10.height,
              const ExpansionTileWidget(
                title: "How can I report inappropriate content or behavior?",
                children:
                    "At HobbyzHub, we take user safety and community guidelines seriously. If you come across any inappropriate content or encounter behavior that goes against our policies, please use the reporting feature within the app to notify our moderation team. We will investigate and take appropriate action.",
              ),
              10.height,
              const ExpansionTileWidget(
                title: "Can I share my hobby-related photos and videos?",
                children:
                    "Absolutely! HobbyzHub allows you to share photos and videos related to your hobbies. You can upload media directly from your device's gallery or capture it within the app. Show off your projects, creations, or experiences with the community!",
              ),
              10.height,
              const ExpansionTileWidget(
                title: "How do I edit my profile information?",
                children:
                    'To edit your profile information, go to your account settings and select the "Edit Profile" option. From there, you can update your bio, profile picture, privacy settings, and other details.',
              ),
              10.height,
              const ExpansionTileWidget(
                title: "Can I share my hobby-related photos and videos?",
                children:
                    "Absolutely! HobbyzHub allows you to share photos and videos related to your hobbies. You can upload media directly from your device's gallery or capture it within the app. Show off your projects, creations, or experiences with the community!",
              ),
              10.height,
            ],
          ),
        ),
      ),
    );
  }
}

class ExpansionTileWidget extends StatelessWidget {
  final String title, children;
  const ExpansionTileWidget(
      {Key? key, required this.title, required this.children})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          collapsedShape: InputBorder.none,
          shape: InputBorder.none,
          // remove borders when expanded
          tilePadding: EdgeInsets.zero,
          title: Text(title),
          children: [Text(children)],
        ),
        const Divider(),
      ],
    );
  }
}
