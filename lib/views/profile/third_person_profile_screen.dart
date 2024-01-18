// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/follower_following/following_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/profile/followers_following_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/profile_image_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:hobbyzhub/views/widgets/text/text_value_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class ThirdPersonProfileScreen extends StatefulWidget {
  const ThirdPersonProfileScreen({Key? key}) : super(key: key);

  @override
  _ThirdPersonProfileScreenState createState() =>
      _ThirdPersonProfileScreenState();
}

class _ThirdPersonProfileScreenState extends State<ThirdPersonProfileScreen> {
  bool? isFollowing;
  @override
  void initState() {
    checkFollowing();
    super.initState();
  }

  checkFollowing() {
    context.read<FollowingBloc>().add(
          FollowingCheckEvent(otherUserId: "otherUserId"),
        );
  }

  followUnfollow() {
    context.read<FollowingBloc>().add(
          FollowingFollowUnfollowEvent(otherUserId: "otherUserId"),
        );
  }

  Widget followFollowingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: isFollowing == false
              ? PrimaryButtonWidget(
                  caption: "Follow",
                  onPressed: () {
                    setState(() {
                      isFollowing = true;
                    });
                  },
                  icon: Ionicons.add,
                )
              : PrimaryButtonWidget(
                  caption: "Following",
                  color: AppColors.grey,
                  onPressed: () {
                    setState(() {
                      isFollowing = false;
                    });
                  },
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
        ).visible(isFollowing!),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FollowingBloc, FollowingState>(
            listener: (context, state) {
              if (state is FollowingCheckState) {
                setState(() {
                  isFollowing = state.response['following'];
                  isFollowing = false;
                });
              } else if (state is FollowingErrorState) {
                setState(() {
                  isFollowing = false;
                });
              }
            },
          ),
        ],
        child: isFollowing == null
            ? const Center(
                child: LoadingWidget(),
              )
            : DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      expandedHeight: context.height() * 0.6,
                      floating: true,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              // profile image
                              const ProfileImageWidget(
                                imageUrl: ImageAssets.userProfileImage,
                                isEditable: false,
                              ),
                              // Name
                              Text("Sara Stamp",
                                  style: AppTextStyle.subHeading),
                              20.height,
                              // Bio
                              const BioTextWidget(
                                bio:
                                    'I just love the idea of not being what people expect me to be!',
                              ),
                              20.height,
                              // Posts, following and followers in one row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <TextValueWidget>[
                                  const TextValueWidget(
                                      text: "85", value: "Posts"),
                                  TextValueWidget(
                                    text: "870",
                                    value: "Following",
                                    onTap: () {
                                      AppNavigator.goToPage(
                                        context: context,
                                        screen: const FollowersFollowingScreen(
                                            index: 1),
                                      );
                                    },
                                  ),
                                  TextValueWidget(
                                    text: "15k",
                                    value: "Followers",
                                    onTap: () {
                                      AppNavigator.goToPage(
                                        context: context,
                                        screen: const FollowersFollowingScreen(
                                            index: 0),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              20.height,
                              followFollowingButton(), 20.height,
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  itemBuilder: (context, index) => Container(
                                    margin: const EdgeInsets.only(right: 8),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ),
                            ],
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
                    children: [
                      PostScreen(),
                      GroupsInCommonScreen(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text("Hello"),
        ),
      ],
    );
  }
}

class GroupsInCommonScreen extends StatelessWidget {
  const GroupsInCommonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Text("Hello"),
        ),
      ],
    );
  }
}
