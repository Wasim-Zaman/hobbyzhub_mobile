// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/follower_following/f_and_f_bloc.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/blocs/user_profile/profile_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/group/group_model.dart';
import 'package:hobbyzhub/utils/app_sheets.dart';
import 'package:hobbyzhub/views/profile/tab_thirdPersonPost_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:hobbyzhub/views/widgets/images/network_image_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/shimmer/follow_following_button_shimmer.dart';
import 'package:hobbyzhub/views/widgets/text/bio_text_widget.dart';
import 'package:hobbyzhub/views/widgets/user_all_count_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class ThirdPersonProfileScreen extends StatefulWidget {
  final String userId;
  const ThirdPersonProfileScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  _ThirdPersonProfileScreenState createState() =>
      _ThirdPersonProfileScreenState();
}

class _ThirdPersonProfileScreenState extends State<ThirdPersonProfileScreen> {
  late ProfileCubit profileCubit;

  // Lists
  List<GroupModel> groups = [];

  @override
  void initState() {
    getProfileInfo();
    getGroupChats();
    super.initState();
  }

  getProfileInfo() {
    profileCubit = context.read<ProfileCubit>();
    profileCubit.getProfileInfo(widget.userId);
  }

  getGroupChats() {
    context.read<GroupBloc>().add(GroupGetChatsEvent(memberId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
      body: DefaultTabController(
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
                              imageUrl:
                                  state.userProfile.first.data.profileImage ??
                                      "",
                              isEditable: false,
                            ),
                            // Name
                            Text(
                              state.userProfile.first.data.fullName,
                              style: AppTextStyle.subHeading,
                            ),
                            20.height,
                            // Bio
                            BioTextWidget(
                              bio: state.userProfile.first.data.bio,
                            ),
                            20.height,
                            // Posts, following and followers in one row

                            FollowFollowingButton(
                              otherUserId: widget.userId,
                            ),

                            20.height,
                            BlocConsumer<GroupBloc, GroupState>(
                              listener: (context, state) {
                                if (state is GroupGetChatsState) {
                                  groups = state.chats;
                                }
                              },
                              builder: (context, state) {
                                return SizedBox(
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
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          // open modal bottom sheet for chat details
                                          AppSheets.groupDetailsSheet(
                                            context,
                                            group: groups[index],
                                          );
                                        },
                                        child: ClipOval(
                                          child: ImageWidget(
                                            imageUrl: groups[index].groupIcon!,
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                            errorWidget: Image.asset(
                                              ImageAssets.createGroupImage,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemCount: groups.length,
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                  ),
                                );
                              },
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
                    bottom: BorderSide(color: AppColors.primary, width: 3.0),
                  ),
                ),
                tabs: [
                  Tab(text: "Posts"),
                  Tab(text: "Groups in common"),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              TabThirdPersonPostScreen(
                userId: widget.userId,
              ),
              const GroupsInCommonScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowFollowingButton extends StatefulWidget {
  final String otherUserId;
  const FollowFollowingButton({Key? key, required this.otherUserId})
      : super(key: key);

  @override
  State<FollowFollowingButton> createState() => _FollowFollowingButtonState();
}

class _FollowFollowingButtonState extends State<FollowFollowingButton> {
  bool following = false;

  @override
  void initState() {
    checkFollowing();
    super.initState();
  }

  checkFollowing() {
    context
        .read<FAndFBloc>()
        .add(FAndFCheckFollowingEvent(otherUserId: widget.otherUserId));
  }

  followUnfollow() {
    context
        .read<FAndFBloc>()
        .add(FAndFFollowUnfollowEvent(otherUserId: widget.otherUserId));
  }

  Widget followFollowingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: following == false
              ? PrimaryButtonWidget(
                  caption: "Follow",
                  onPressed: () {
                    followUnfollow();
                  },
                  icon: Ionicons.add,
                )
              : PrimaryButtonWidget(
                  caption: "Following",
                  color: AppColors.grey,
                  onPressed: () {
                    followUnfollow();
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
        ).visible(following),
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
    return BlocConsumer<FAndFBloc, FAndFState>(
      listener: (context, state) {
        if (state is FAndFCheckState) {
          following = state.response['following'];
        } else if (state is FAndFFollowUnfollowState) {
          following = !following;
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            UserAllCountWidget(
              isThirdPerson: true,
              userId: widget.otherUserId,
            ),
            20.height,
            (state is FAndFLoadingState)
                ? const FollowFollowingButtonShimmer()
                : followFollowingButton(),
          ],
        );
      },
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
