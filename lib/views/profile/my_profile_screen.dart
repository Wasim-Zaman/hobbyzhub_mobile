// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/group/group_bloc.dart';
import 'package:hobbyzhub/blocs/user_profile/profile_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/user/user_profile_model.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/app_sheets.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/profile/edit_profile/edit_profile_screen.dart';
import 'package:hobbyzhub/views/profile/settings/settings_screen.dart';
import 'package:hobbyzhub/views/profile/tab_userpost_screen.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/groups_in_common_widget.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
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
  String? userId;

  UserProfileModel? profileInfo;

  // Lists
  List<GroupChat> groups = [];

  initCubit() async {
    userId = await UserSecureStorage.fetchUserId();
    setState(() {});

    profileCubit = context.read<ProfileCubit>();
    profileCubit.getProfileInfo(userId);
  }

  getGroupChats() {
    context.read<GroupBloc>().add(GroupGetChatsEvent());
  }

  @override
  void initState() {
    initCubit();
    getGroupChats();
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
                          child: BlocConsumer<ProfileCubit, ProfileState>(
                            listener: (context, state) {
                              if (state is GetProfileLoaded) {
                                profileInfo = state.userProfile.first;
                              }
                            },
                            builder: (context, state) {
                              if (state is GetProfileLoading) {
                                return const LoadingWidget();
                              } else if (state is GetProfileLoaded) {
                                return Column(
                                  children: [
                                    // profile image
                                    NetworkImageWidget(
                                      imageUrl: state.userProfile.first.data
                                              .profileImage ??
                                          "",
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
                                    const UserAllCountWidget(
                                      isThirdPerson: null,
                                      userId: null,
                                    ),
                                    20.height,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: PrimaryButtonWidget(
                                            caption: "Edit Profile",
                                            onPressed: () {
                                              AppNavigator.goToPage(
                                                context: context,
                                                screen: EditProfileScreen(
                                                  editProfile:
                                                      state.userProfile.first,
                                                ),
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
                                                screen: SettingsScreen(
                                                  user: state.userProfile.first,
                                                ),
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
                                    ),
                                    20.height,
                                    StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('group-chats')
                                            .where('type', isEqualTo: 'GROUP')
                                            .where(
                                              'participantIds',
                                              arrayContains: userId.toString(),
                                            )
                                            // .orderBy('lastMessage.timestamp', descending: true)
                                            .limit(100)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child: LoadingWidget(),
                                            );
                                          }

                                          groups = snapshot.data!.docs
                                              .map((doc) => GroupChat.fromJson(
                                                  doc.data()))
                                              .toList();
                                          return SizedBox(
                                            height: 60,
                                            child: ListView.builder(
                                              itemBuilder: (context, index) =>
                                                  Container(
                                                margin: const EdgeInsets.only(
                                                    right: 8),
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
                                                      imageUrl: groups[index]
                                                              .groupImage ??
                                                          '',
                                                      height: 60,
                                                      width: 60,
                                                      fit: BoxFit.cover,
                                                      errorWidget: Image.asset(
                                                        ImageAssets
                                                            .createGroupImage,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              itemCount: groups.length,
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                            ),
                                          );
                                        }),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    20.height,
                                    const Text("Something went wrong!"),
                                  ],
                                );
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
                          Tab(text: "Groups"),
                        ],
                      ),
                    ),
                  ],
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const TabPostScreen(),
                      GroupsInCommonWidget(
                        otherUserId: userId.toString(),
                        myId: null,
                      ),
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
