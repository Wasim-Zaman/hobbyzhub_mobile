import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/text/content_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(title: "About us"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About HobbyzHub",
                style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
              ),
              10.height,
              const ContentWidget(
                header: "",
                content:
                    "Welcome to HobbyzHub, the social media platform designed exclusively for hobby enthusiasts! At HobbyzHub, we believe that hobbies have the power to bring people together, inspire creativity, and foster meaningful connections.",
              ),
              20.height,
              Text(
                "Our Mission",
                style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
              ),
              10.height,
              const ContentWidget(
                header: "",
                content:
                    "Our mission is to create a vibrant and inclusive community where individuals from all walks of life can discover, share, and connect based on their passions and hobbies. We aim to provide a platform that celebrates the diversity of hobbies and provides a space for users to showcase their interests, learn from others, and find like-minded individuals who share their enthusiasm.",
              ),
              20.height,
              Text(
                "Discover, Connect, and Inspire",
                style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
              ),
              10.height,
              const ContentWidget(
                header: "",
                content:
                    "HobbyzHub is your gateway to a world of hobbies. Whether you're an avid painter, a passionate musician, a dedicated gardener, or a tech enthusiast, HobbyzHub offers a space for you to explore, connect, and be inspired by others who share your interests.",
              ),
              20.height,
              Text(
                "Key Features",
                style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
              ),
              10.height,
              const ContentWidget(
                header: "Profile Showcase: ",
                content:
                    "Create a personalized profile that highlights your hobbies, skills, and interests. Showcase your projects, creations, or experiences and let others get to know you through your passion.",
              ),
              10.height,
              const ContentWidget(
                header: "Hobby Groups: ",
                content:
                    "Join or create hobby-specific groups to connect with others who share your interests. Engage in discussions, share tips and advice, and collaborate on projects within a community of fellow enthusiasts.",
              ),
              10.height,
              const ContentWidget(
                header: "Discover New Hobbies: ",
                content:
                    "Explore a wide range of hobby categories and discover new activities to ignite your curiosity. Our curated recommendations and search functionality make it easy for you to find hobbies that align with your interests.",
              ),
              10.height,
              const ContentWidget(
                header: "Connect and Collaborate: ",
                content:
                    "Connect with like-minded individuals, follow their activities, and engage in conversations. Collaborate on projects, share ideas, and learn from each other's expertise.",
              ),
              10.height,
              const ContentWidget(
                header: "Inspirational Content: ",
                content:
                    "Find inspiration through a feed filled with captivating hobby-related photos, videos, stories, and articles shared by our passionate community.",
              ),
              20.height,
              Text(
                "Join the HobbyzHub Community!",
                style: AppTextStyle.subHeading.copyWith(color: AppColors.black),
              ),
              10.height,
              const ContentWidget(
                header: "",
                content:
                    "Whether you're a hobbyist looking to connect with others who share your interests, a beginner seeking guidance and inspiration, or simply someone who wants to explore the fascinating world of hobbies, HobbyzHub is here to empower and engage you.",
              ),
              10.height,
              const ContentWidget(
                header: "",
                content:
                    "Join our growing community of passionate individuals and embark on a journey of discovery, creativity, and connection. Let HobbyzHub be your go-to platform for all things hobbies!",
              ),
              20.height
            ],
          ),
        ),
      ),
    );
  }
}
