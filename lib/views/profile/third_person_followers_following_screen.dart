import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hobbyzhub/blocs/follower_following/f_and_f_bloc.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/follower/follower_model.dart';
import 'package:hobbyzhub/views/widgets/appbars/two_buttons_appbar.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/tabs/tabs_widget.dart';
import 'package:ionicons/ionicons.dart';

class ThirdPersonFollowersFollowingScreen extends StatelessWidget {
  final int index;
  const ThirdPersonFollowersFollowingScreen({super.key, required this.index});

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
    context.read<FAndFBloc>().add(FAndFInitialOtherFollowersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FAndFBloc, FAndFState>(
      listener: (context, state) {
        if (state is FAndFInitialFollowersState) {
          followers = state.response.data;
        } else if (state is FAndFErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FAndFLoadingState) {
          return const LoadingWidget();
        } else if (state is FAndFErrorState) {
          return Center(child: Text(state.message));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return FollowerTile(
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

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  List<FollowerModel> followings = [];

  @override
  void initState() {
    context.read<FAndFBloc>().add(FAndFInitialOtherFollowingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FAndFBloc, FAndFState>(
      listener: (context, state) {
        if (state is FAndFInitialFollowingState) {
          followings = state.response.data;
        } else if (state is FAndFErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is FAndFLoadingState) {
          return const LoadingWidget();
        } else if (state is FAndFErrorState) {
          return Center(child: Text(state.message));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return FollowerTile(model: followings[index], activeStatus: true);
          },
          itemCount: followings.length,
        );
      },
    );
  }
}

class FollowerTile extends StatefulWidget {
  final FollowerModel model;
  final bool activeStatus;
  const FollowerTile({
    Key? key,
    required this.model,
    required this.activeStatus,
  }) : super(key: key);

  @override
  State<FollowerTile> createState() => _FollowerTileState();
}

class _FollowerTileState extends State<FollowerTile> {
  late bool _isFollow;
  late FAndFBloc bloc;

  @override
  void initState() {
    if (widget.model.following != null) {
      _isFollow = widget.model.following ?? true;
    }
    bloc = FAndFBloc();
    super.initState();
  }

  followUnfollow() {
    // Follow or unfollow user
    bloc.add(
      FAndFFollowUnfollowEvent(otherUserId: widget.model.userId!),
    );
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
      title: Text(widget.model.fullName.toString()),
      // subtitle: Text(widget.lastSeen),
      trailing: BlocConsumer<FAndFBloc, FAndFState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is FAndFErrorState) {
            // Show error
            _isFollow = false;
          } else if (state is FAndFFollowUnfollowState) {
            // Show success
            _isFollow = !_isFollow;
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              // Follow or unfollow user
              followUnfollow();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isFollow ? AppColors.grey : AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              foregroundColor: AppColors.white,
            ),
            child: (state is FAndFLoadingState)
                ? FittedBox(
                    child: Center(
                        child: LoadingWidget(
                      color: !_isFollow ? AppColors.grey : AppColors.primary,
                    )),
                  )
                : Text(
                    _isFollow ? "Following" : "Follow",
                    style: AppTextStyle.button.copyWith(color: AppColors.white),
                  ),
          );
        },
      ),
    );
  }
}
