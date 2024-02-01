// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/user_profile/profile_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/profile/edit_profile/edit_profile_screen.dart';
import 'package:hobbyzhub/views/profile/settings/settings_screen.dart';
import 'package:hobbyzhub/views/profile/tab_userpost_screen.dart';
import 'package:hobbyzhub/views/profile/third_person_profile_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/network_image_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:hobbyzhub/views/widgets/user_all_count_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late ProfileCubit profileCubit;

  initCubit() async {
    final userId = await UserSecureStorage.fetchUserId();

    profileCubit = context.read<ProfileCubit>();
    profileCubit.getProfileInfo(userId);
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return const LoadingWidget();
            } else if (state is GetProfileLoaded) {
              return DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      expandedHeight: context.height() * 0.6,
                      floating: true,
                      pinned: true,
                      leading: const SizedBox(),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          padding: const EdgeInsets.all(16),
                          child: BlocBuilder<ProfileCubit, ProfileState>(
                            builder: (context, state) {
                              if (state is GetProfileLoading) {
                                return const LoadingWidget();
                              } else if (state is GetProfileLoaded) {
                                return Column(
                                  children: [
                                    // profile image
                                    NetworkImageWidget(
                                      imageUrl: state
                                          .userProfile.first.data.profileImage,
                                      isEditable: false,
                                    ),
                                    // Name
                                    Text(state.userProfile.first.data.fullName,
                                        style: AppTextStyle.subHeading),
                                    20.height,
                                    // Bio
                                    BioTextWidget(
                                      bio: state.userProfile.first.data.bio,
                                    ),
                                    20.height,
                                    // Posts, following and followers in one row
                                    const UserAllCountWidget(),
                                    20.height,
                                    const ProfileWidgets(),
                                    20.height,
                                    SizedBox(
                                      height: 60,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            Container(
                                          margin:
                                              const EdgeInsets.only(right: 8),
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.darkGrey,
                                            ),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                ImageAssets.userProfileImage,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        itemCount: 8,
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                      ),
                      bottom: const TabBar(
                        indicatorColor: AppColors.primary,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.black,
                        indicator: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: AppColors.primary, width: 3.0),
                          ),
                        ),
                        tabs: [
                          Tab(text: "Posts"),
                          Tab(text: "Groups in common"),
                        ],
                      ),
                    ),
                  ],
                  body: const TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      TabPostScreen(),
                      GroupsInCommonScreen(),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
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
            onPressed: () {
              AppNavigator.goToPage(
                context: context,
                screen: const EditProfileScreen(),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              AppNavigator.goToPage(
                context: context,
                screen: const SettingsScreen(),
              );
            },
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
