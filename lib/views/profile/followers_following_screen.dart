import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/follower_following/follower_bloc.dart';
import 'package:hobbyzhub/blocs/follower_following/following_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/follower/follower_model.dart';
import 'package:hobbyzhub/views/widgets/appbars/two_buttons_appbar.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/tabs/tabs_widget.dart';
import 'package:ionicons/ionicons.dart';

class FollowersFollowingScreen extends StatelessWidget {
  final int index;
  const FollowersFollowingScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return TabsWidget(
      appBar: const TwoButtonsAppbar(
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
      index: index,
      length: 2,
      children: const [
        FollowersScreen(), // Content for the first tab
        FollowingScreen(), // Content for the second tab
      ],
    );
  }
}

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  List<FollowerModel> followers = [];
  @override
  void initState() {
    context.read<FollowerBloc>().add(FollowerGetInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FollowerBloc, FollowerState>(
      listener: (context, state) {
        if (state is FollowerGetInitialState) {
          followers = state.response.data;
        } else if (state is FollowerErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FollowerLoadingState) {
          return const LoadingWidget();
        } else if (state is FollowerErrorState) {
          return Center(child: Text(state.message));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return FollowerFollowingListTile(
              model: followers[index],
              activeStatus: true,
            );
          },
          itemCount: followers.length,
        );
      },
    );
  }
}

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}

class FollowerFollowingListTile extends StatefulWidget {
  final FollowerModel model;
  final bool activeStatus;
  const FollowerFollowingListTile({
    Key? key,
    required this.model,
    required this.activeStatus,
  }) : super(key: key);

  @override
  State<FollowerFollowingListTile> createState() =>
      _FollowerFollowingListTileState();
}

class _FollowerFollowingListTileState extends State<FollowerFollowingListTile> {
  late bool _isFollow;

  @override
  void initState() {
    _isFollow = widget.model.following!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          Image.asset(ImageAssets.userProfileImage),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: widget.activeStatus ? AppColors.success : AppColors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),
            ),
          )
        ],
      ),
      title: Text(widget.model.fullName!),
      // subtitle: Text(widget.lastSeen),
      trailing: ElevatedButton(
        onPressed: () {
          // Follow or unfollow user
          context.read<FollowingBloc>().add(
                FollowingFollowUnfollowEvent(otherUserId: widget.model.userId!),
              );
          setState(() {
            _isFollow = !_isFollow;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isFollow ? AppColors.grey : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          foregroundColor: AppColors.white,
        ),
        child: Text(
          _isFollow ? "Following" : "follow",
          style: AppTextStyle.button.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
