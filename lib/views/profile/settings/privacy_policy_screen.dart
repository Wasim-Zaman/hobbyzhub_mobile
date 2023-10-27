import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "Privacy Policies"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              "Privacy Policies for HobbyzHub",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            Text(
              "At HobbyzHub, we are committed to protecting the privacy and personal information of our users. This Privacy Policy outlines how we collect, use, store, and disclose information when you use our social media application. By using HobbyzHub, you agree to the terms and practices described in this Privacy Policy.",
              style: AppTextStyle.normal.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            20.height,
            Text(
              "1. Information We Collect",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            const ContentWidget(
              header: "Personal Information: ",
              content:
                  "Personal Information: When you sign up for HobbyzHub, we may collect personal information such as your name, email address, profile picture, date of birth, and other details you choose to provide.",
            ),
            10.height,
            const ContentWidget(
              header: "Usage Information: ",
              content:
                  "We may collect information about your interactions with the application, including your hobbies, posts, comments, likes, and other activities.",
            ),
            10.height,
            const ContentWidget(
              header: "Device Information: ",
              content:
                  "We may collect information about the device you use to access HobbyzHub, including your device type, operating system, unique device identifiers, IP address, and mobile network information.",
            ),
            20.height,
            Text(
              "2. How We Use Your Information",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            const ContentWidget(
              header: "Personalization: ",
              content:
                  "We use the information we collect to personalize your HobbyzHub experience, including suggesting relevant hobbies, connecting you with like-minded individuals, and providing tailored content.",
            ),
            10.height,
            const ContentWidget(
              header: "Communication: ",
              content:
                  "We may use your email address to send you important updates, notifications, and promotional materials related to HobbyzHub. You can opt-out of promotional emails at any time.",
            ),
            10.height,
            const ContentWidget(
              header: "Improvements: ",
              content:
                  "We analyze user behavior and feedback to improve our application's features, functionality, and user experience.",
            ),
            20.height,
            Text(
              "3. Informatio sharing and disclosure",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            const ContentWidget(
              header: "User Interactions: ",
              content:
                  "HobbyzHub is designed to facilitate social interactions. Therefore, certain information you provide, such as your username, profile picture, and hobbies, may be visible to other users of the application.",
            ),
            10.height,
            const ContentWidget(
              header: "Third Parties: ",
              content:
                  "We may share your information with trusted third-party service providers who assist us in operating, maintaining, and improving HobbyzHub. These third parties are bound by confidentiality obligations and are prohibited from using your information for any other purpose.",
            ),
            20.height,
            Text(
              "4. Data Security",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            const ContentWidget(
              header: "",
              content:
                  "We take reasonable measures to protect the security of your information and employ industry-standard security practices to safeguard it. However, please note that no method of transmission or storage is entirely secure, and we cannot guarantee absolute security.",
            ),
            20.height,
            Text(
              "5. Changes to the Privacy Policy",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            const ContentWidget(
              header: "",
              content:
                  "We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the updated Privacy Policy within the HobbyzHub application or by other means. It is your responsibility to review the Privacy Policy periodically.",
            ),
            20.height,
            Text(
              "6. Contact Us",
              style: AppTextStyle.subHeading.copyWith(
                color: AppColors.black,
              ),
            ),
            10.height,
            const ContentWidget(
              header: "",
              content:
                  "If you have any questions, concerns, or feedback regarding this Privacy Policy or HobbyzHub's privacy practices, please contact us at example@gmail.com",
            ),
            20.height,
          ],
        ),
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final String header, content;
  const ContentWidget({Key? key, required this.header, required this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: header,
            style: AppTextStyle.normal.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: content,
            style: AppTextStyle.normal.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
