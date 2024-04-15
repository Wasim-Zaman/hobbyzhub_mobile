import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/create_story/create_story_cubit.dart';
import 'package:hobbyzhub/blocs/delete_post/delete_post_cubit.dart';
import 'package:hobbyzhub/blocs/get_post/get_post_cubit.dart';
import 'package:hobbyzhub/blocs/get_stories/get_stories_cubit.dart';
import 'package:hobbyzhub/blocs/like_post/likes_cubit.dart';
import 'package:hobbyzhub/blocs/unlike_post/unlike_post_cubit.dart';
import 'package:hobbyzhub/blocs/user_profile/profile_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/post_model/post_model.dart';
import 'package:hobbyzhub/utils/app_dialogs.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/utils/secure_storage.dart';
import 'package:hobbyzhub/views/explore/explore_screen.dart';
import 'package:hobbyzhub/views/post/comments/comment_screen.dart';
import 'package:hobbyzhub/views/post/story/story_screen.dart';
import 'package:hobbyzhub/views/profile/third_person_profile_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/basic_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timeago/timeago.dart' as timeago;

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  return timeago.format(now.subtract(difference), locale: 'en');
}

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String? userId;
  late ProfileCubit profileCubit;
  List<PostModel> posts = [];

  @override
  void initState() {
    fetchUserInformation();
    super.initState();
  }

  fetchUserInformation() async {
    userId = await UserSecureStorage.fetchUserId();
    profileCubit = context.read<ProfileCubit>();
    profileCubit.getProfileInfo(userId);
    context.read<GetStoriesCubit>().getStoriesList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateStoryCubit, CreateStoryState>(
          listener: (context, state) async {
            if (state is CreatestoryLoading) {
              // unfocus keyboard
              FocusScope.of(context).unfocus();
              // show loading
              AppDialogs.loadingDialog(context);
              Navigator.of(context).pop();
            } else if (state is CreatestorySuccessfully) {
              AppDialogs.closeDialog(context);
              context.read<GetStoriesCubit>().getStoriesList();
              // save token to local storage
            } else if (state is CreatestoryFailed) {
              AppDialogs.closeDialog(context);
              toast("Failed to upload");
            }
          },
        ),
        BlocListener<DeletePostCubit, DeletePostState>(
          listener: (context, state) {
            if (state is DeletePostLoaded) {
              context.read<GetPostCubit>().getPostList();
            }
          },
        ),
        BlocListener<LikesCubit, LikesState>(
          listener: (context, state) {
            if (state is LikeSuccessfully) {
              context.read<GetPostCubit>().getPostList();
            }
          },
        ),
        BlocListener<UnlikePostCubit, UnlikePostState>(
          listener: (context, state) {
            if (state is UnLikeSuccessfully) {
              context.read<GetPostCubit>().getPostList();
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BasicAppbarWidget(
          title: 'Feeds',
          isBackButton: false,
          actions: [
            IconButton(
              onPressed: () {
                AppNavigator.goToPage(
                  context: context,
                  screen: const ExploreScreen(),
                );
              },
              icon: Image.asset(ImageAssets.searchImage, height: 20, width: 20),
            ),
            // IconButton(
            //   onPressed: () {
            //     AppNavigator.goToPage(
            //       context: context,
            //       screen: const NotificationScreen(),
            //     );
            //   },
            //   icon:
            //       Image.asset(ImageAssets.notification, height: 20, width: 20),
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 20.w,
                      height: 150.h,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            //! Profile Section
                            BlocBuilder<ProfileCubit, ProfileState>(
                              builder: (context, state) {
                                if (state is GetProfileLoaded) {
                                  return GestureDetector(
                                    onTap: () async {
                                      showBottomSheet(context);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          height: 120.h,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 100.w,
                                                  height: 120.h,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(state
                                                              .userProfile
                                                              .first
                                                              .data
                                                              .profileImage ??
                                                          ''),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 40.w,
                                                top: 90.h,
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: AppColors.primary,
                                                    shape: OvalBorder(
                                                      side: BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Story',
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTextStyle.normalFontTextStyle,
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      showBottomSheet(context);
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          height: 120.h,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 100.w,
                                                  height: 120.h,
                                                  decoration: ShapeDecoration(
                                                    image:
                                                        const DecorationImage(
                                                      image: NetworkImage(
                                                          "https://via.placeholder.com/70x100"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 40.w,
                                                top: 90.h,
                                                child: Container(
                                                  width: 25.w,
                                                  height: 25.h,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: AppColors.primary,
                                                    shape: OvalBorder(
                                                      side: BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.add,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'Your Story',
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTextStyle.normalFontTextStyle,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                            //! Stories
                            BlocBuilder<GetStoriesCubit, GetStoriesState>(
                              builder: (context, state) {
                                if (state is GetStoriesLoaded) {
                                  return ListView.builder(
                                      itemCount: state.storiesList.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: SizedBox(
                                              child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(
                                                      context)
                                                  .push(MaterialPageRoute(
                                                      builder:
                                                          (builder) => StoryScreen(
                                                              images: state
                                                                  .storiesList[
                                                                      index]
                                                                  .storyImages,
                                                              userName: state
                                                                  .storiesList[
                                                                      index]
                                                                  .username,
                                                              creationTime: state
                                                                  .storiesList[
                                                                      index]
                                                                  .creationTime)));
                                            },
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // decoration: BoxDecoration(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(
                                                  //           20,),
                                                  //   border: Border.all(
                                                  //     color:
                                                  //         AppColors.borderGrey,
                                                  //     width: 2,
                                                  //   ),
                                                  // ),
                                                  width: 100.w,
                                                  height: 120.h,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 0,
                                                        top: 0,
                                                        child: Container(
                                                          width: 100.w,
                                                          height: 120.h,
                                                          decoration:
                                                              ShapeDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  "${state.storiesList[index].storyImages[0]}"),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                    '${state.storiesList[index].username}',
                                                    textAlign: TextAlign.center,
                                                    style: AppTextStyle
                                                        .normalFontTextStyle),
                                              ],
                                            ),
                                          )),
                                        );
                                      });
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //! Posts Section
              BlocConsumer<GetPostCubit, GetPostState>(
                listener: (context, state) {
                  if (state is GetPostLoaded) {
                    posts = state.postsList;
                  }
                },
                builder: (context, state) {
                  if (state is GetPostLoading) {
                    return state.postsList.length == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              const LoadingWidget()
                            ],
                          )
                        : ListView.builder(
                            itemCount: state.postsList.first.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        state.postsList.first.data[index]
                                                    .profileImage ==
                                                null
                                            ? CircleAvatar(
                                                radius: 20.sp,
                                                child: state
                                                        .postsList
                                                        .first
                                                        .data[index]
                                                        .username
                                                        .isNotEmpty
                                                    ? Text(state.postsList.first
                                                        .data[index].username
                                                        .toString()
                                                        .substring(0, 1))
                                                    : const Text(''),
                                              )
                                            : CircleAvatar(
                                                radius: 20.sp,
                                                backgroundImage: NetworkImage(
                                                    state
                                                        .postsList
                                                        .first
                                                        .data[index]
                                                        .profileImage),
                                              ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              Text(
                                                  state.postsList.first
                                                      .data[index].username,
                                                  style: AppTextStyle
                                                      .notificationTitleTextStyle),
                                              Text(
                                                  formatDateTime(state
                                                      .postsList
                                                      .first
                                                      .data[index]
                                                      .postTime),
                                                  style: AppTextStyle
                                                      .normalFontTextStyle)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: PopupMenuButton<int>(
                                            onSelected: (item) {
                                              switch (item) {
                                                case 0:
                                                  context
                                                      .read<DeletePostCubit>()
                                                      .deletePost(state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .postId);
                                                  break;
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem<int>(
                                                  value: 0,
                                                  child: Text('Delete')),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    state.postsList.first.data[index].caption !=
                                            null
                                        ? Row(
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                    state.postsList.first
                                                        .data[index].caption!,
                                                    style: AppTextStyle
                                                        .normalFontTextStyle),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    state.postsList.first.data[index]
                                                .hashTags !=
                                            null
                                        ? Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .hashTags!
                                                          .length;
                                                  i++) ...[
                                                SizedBox(
                                                  child: Text(
                                                      "#${state.postsList.first.data[index].hashTags![i].tagName}",
                                                      style: AppTextStyle
                                                          .codeTextStyle),
                                                ),
                                              ]
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    state.postsList.first.data[index].imageUrls
                                                .length ==
                                            1
                                        ? CachedNetworkImage(
                                            imageUrl: state.postsList.first
                                                .data[index].imageUrls.first,
                                            placeholder: (context, url) =>
                                                const LoadingWidget(), // Empty container as a placeholder
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: double
                                                  .infinity, // Set the width as needed
                                              height:
                                                  210, // Set the height as needed
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                    8.0), // Set border radius as needed
                                              ),
                                            ),

                                            fit: BoxFit.cover,
                                            fadeInDuration: const Duration(
                                                milliseconds: 500),
                                            fadeOutDuration: const Duration(
                                                milliseconds: 500),
                                            alignment: Alignment.center,
                                            repeat: ImageRepeat.noRepeat,
                                            filterQuality: FilterQuality.high,

                                            width: double
                                                .infinity, // Set the width as needed
                                            height:
                                                210, // Set the width as needed
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.1, // Set the width as needed
                                            height: 210,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: state.postsList.first
                                                  .data[index].imageUrls.length,
                                              itemBuilder: (context, _index) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.1, // Set the width as needed
                                                  height:
                                                      210, // Set the height as needed
                                                  margin: const EdgeInsets.only(
                                                      right:
                                                          2.0), // Add margin between images
                                                  child: Stack(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: state
                                                            .postsList
                                                            .first
                                                            .data[index]
                                                            .imageUrls[_index],
                                                        placeholder: (context,
                                                                url) =>
                                                            const LoadingWidget(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                        fit: BoxFit.cover,
                                                        fadeInDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        fadeOutDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        alignment:
                                                            Alignment.center,
                                                        repeat: ImageRepeat
                                                            .noRepeat,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .picture_in_picture_sharp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 120.w,
                                          height: 20.h,
                                          child: Stack(
                                              children: List.generate(
                                                  state
                                                      .postsList
                                                      .first
                                                      .data[index]
                                                      .comments
                                                      .length, (_index) {
                                            return Positioned(
                                                left: 20.0 * index,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: state
                                                              .postsList
                                                              .first
                                                              .data[index]
                                                              .comments[_index]
                                                              .profileImage ==
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 10.sp,
                                                          child: state
                                                                  .postsList
                                                                  .first
                                                                  .data[index]
                                                                  .comments[
                                                                      _index]
                                                                  .username
                                                                  .isNotEmpty
                                                              ? Text(state
                                                                  .postsList
                                                                  .first
                                                                  .data[index]
                                                                  .comments[
                                                                      _index]
                                                                  .username
                                                                  .toString()
                                                                  .substring(
                                                                      0, 1))
                                                              : const Text(''),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 10.sp,
                                                          backgroundImage:
                                                              NetworkImage(state
                                                                  .postsList
                                                                  .first
                                                                  .data[index]
                                                                  .comments[
                                                                      _index]
                                                                  .profileImage),
                                                        ),
                                                ));
                                          })),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: state.postsList.first
                                                      .data[index].likes
                                                      .any((element) =>
                                                          element.userId ==
                                                          userId)
                                                  ? () {
                                                      var data = state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .likes
                                                          .where((element) =>
                                                              element.userId ==
                                                              userId);

                                                      context
                                                          .read<
                                                              UnlikePostCubit>()
                                                          .createUnLike(data
                                                              .first.likeId);
                                                      print(data.first.likeId);
                                                    }
                                                  : () {
                                                      context
                                                          .read<LikesCubit>()
                                                          .createLike(state
                                                              .postsList
                                                              .first
                                                              .data[index]
                                                              .postId);
                                                    },
                                              child: state.postsList.first
                                                      .data[index].likes
                                                      .any((element) =>
                                                          element.userId ==
                                                          userId)
                                                  ? const Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      CupertinoIcons.heart,
                                                      color: Colors.black,
                                                    ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              '${state.postsList.first.data[index].likes.length}',
                                              style: AppTextStyle
                                                  .normalFontTextStyle,
                                            ),
                                            SizedBox(width: 20.w),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Image.asset(
                                                ImageAssets.messageImage,
                                                height: 20.h,
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                                '${state.postsList.first.data[index].comments.length}',
                                                style: AppTextStyle
                                                    .normalFontTextStyle),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: 'Liked by ',
                                                    style: AppTextStyle
                                                        .likeByTextStyle),
                                                TextSpan(
                                                    text: state
                                                            .postsList
                                                            .first
                                                            .data[index]
                                                            .likes
                                                            .isNotEmpty
                                                        ? '${state.postsList.first.data[index].likes.first.username}'
                                                        : 'None',
                                                    style: AppTextStyle
                                                        .likeByTextStyle),
                                                state
                                                            .postsList
                                                            .first
                                                            .data[index]
                                                            .likes
                                                            .length >
                                                        1
                                                    ? TextSpan(
                                                        text:
                                                            ' and ${state.postsList.first.data[index].likes.length} others',
                                                        style: AppTextStyle
                                                            .likeByTextStyle)
                                                    : const TextSpan(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    CommentScreen(
                                                      postId: state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .postId!,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Opacity(
                                              opacity: 0.50,
                                              child: Text(
                                                  'View all ${state.postsList.first.data[index].comments.length} comments',
                                                  style: AppTextStyle
                                                      .likeByTextStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                  } else if (state is GetPostLoaded) {
                    return state.postsList.length == 0
                        ? Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 4,
                              ),
                              const Text('Post not found'),
                            ],
                          )
                        : ListView.builder(
                            itemCount: state.postsList.first.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        state.postsList.first.data[index]
                                                    .profileImage ==
                                                null
                                            ? CircleAvatar(
                                                radius: 20.sp,
                                                child: state
                                                        .postsList
                                                        .first
                                                        .data[index]
                                                        .username
                                                        .isNotEmpty
                                                    ? Text(state.postsList.first
                                                        .data[index].username
                                                        .toString()
                                                        .substring(0, 1))
                                                    : const Text(''),
                                              )
                                            : CircleAvatar(
                                                radius: 20.sp,
                                                backgroundImage: NetworkImage(
                                                    state
                                                        .postsList
                                                        .first
                                                        .data[index]
                                                        .profileImage),
                                              ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  userId ==
                                                          state
                                                              .postsList
                                                              .first
                                                              .data[index]
                                                              .userId
                                                      ? null
                                                      : AppNavigator.goToPage(
                                                          context: context,
                                                          screen:
                                                              ThirdPersonProfileScreen(
                                                                  userId: state
                                                                      .postsList
                                                                      .first
                                                                      .data[
                                                                          index]
                                                                      .userId),
                                                        );
                                                },
                                                child: Text(
                                                    state.postsList.first
                                                        .data[index].username,
                                                    style: AppTextStyle
                                                        .notificationTitleTextStyle),
                                              ),
                                              Text(
                                                  formatDateTime(state
                                                      .postsList
                                                      .first
                                                      .data[index]
                                                      .postTime),
                                                  style: AppTextStyle
                                                      .normalFontTextStyle)
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: PopupMenuButton<int>(
                                            onSelected: (item) {
                                              switch (item) {
                                                case 0:
                                                  context
                                                      .read<DeletePostCubit>()
                                                      .deletePost(state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .postId);
                                                  break;
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem<int>(
                                                  value: 0,
                                                  child: Text('Delete')),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    state.postsList.first.data[index].caption !=
                                            null
                                        ? Row(
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                    state.postsList.first
                                                        .data[index].caption!,
                                                    style: AppTextStyle
                                                        .normalFontTextStyle),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    state.postsList.first.data[index]
                                                .hashTags !=
                                            null
                                        ? Row(
                                            children: [
                                              for (int i = 0;
                                                  i <
                                                      state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .hashTags!
                                                          .length;
                                                  i++) ...[
                                                SizedBox(
                                                  child: Text(
                                                      "#${state.postsList.first.data[index].hashTags![i].tagName}",
                                                      style: AppTextStyle
                                                          .codeTextStyle),
                                                ),
                                              ]
                                            ],
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    state.postsList.first.data[index].imageUrls
                                                .length ==
                                            1
                                        ? CachedNetworkImage(
                                            imageUrl: state.postsList.first
                                                .data[index].imageUrls.first,
                                            placeholder: (context, url) =>
                                                const LoadingWidget(), // Empty container as a placeholder
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: double
                                                  .infinity, // Set the width as needed
                                              height:
                                                  210, // Set the height as needed
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.circular(
                                                    8.0), // Set border radius as needed
                                              ),
                                            ),

                                            fit: BoxFit.cover,
                                            fadeInDuration: const Duration(
                                                milliseconds: 500),
                                            fadeOutDuration: const Duration(
                                                milliseconds: 500),
                                            alignment: Alignment.center,
                                            repeat: ImageRepeat.noRepeat,
                                            filterQuality: FilterQuality.high,

                                            width: double
                                                .infinity, // Set the width as needed
                                            height:
                                                210, // Set the width as needed
                                          )
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.1, // Set the width as needed
                                            height: 210,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: state.postsList.first
                                                  .data[index].imageUrls.length,
                                              itemBuilder: (context, _index) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.1, // Set the width as needed
                                                  height:
                                                      210, // Set the height as needed
                                                  margin: const EdgeInsets.only(
                                                      right:
                                                          2.0), // Add margin between images
                                                  child: Stack(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: state
                                                            .postsList
                                                            .first
                                                            .data[index]
                                                            .imageUrls[_index],
                                                        placeholder: (context,
                                                                url) =>
                                                            const LoadingWidget(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                        fit: BoxFit.cover,
                                                        fadeInDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        fadeOutDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        alignment:
                                                            Alignment.center,
                                                        repeat: ImageRepeat
                                                            .noRepeat,
                                                        filterQuality:
                                                            FilterQuality.high,
                                                      ),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .picture_in_picture_sharp,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 120.w,
                                          height: 20.h,
                                          child: Stack(
                                              children: List.generate(
                                                  state
                                                      .postsList
                                                      .first
                                                      .data[index]
                                                      .comments
                                                      .length, (_index) {
                                            return Positioned(
                                                left: 20.0 * index,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: state
                                                              .postsList
                                                              .first
                                                              .data[index]
                                                              .comments[_index]
                                                              .profileImage ==
                                                          null
                                                      ? CircleAvatar(
                                                          radius: 10.sp,
                                                          child: state
                                                                  .postsList
                                                                  .first
                                                                  .data[index]
                                                                  .comments[
                                                                      _index]
                                                                  .username
                                                                  .isNotEmpty
                                                              ? Text(state
                                                                  .postsList
                                                                  .first
                                                                  .data[index]
                                                                  .comments[
                                                                      _index]
                                                                  .username
                                                                  .toString()
                                                                  .substring(
                                                                      0, 1))
                                                              : const Text(''),
                                                        )
                                                      : CircleAvatar(
                                                          radius: 10.sp,
                                                          backgroundImage:
                                                              NetworkImage(state
                                                                  .postsList
                                                                  .first
                                                                  .data[index]
                                                                  .comments[
                                                                      _index]
                                                                  .profileImage),
                                                        ),
                                                ));
                                          })),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: state.postsList.first
                                                      .data[index].likes
                                                      .any((element) =>
                                                          element.userId ==
                                                          userId)
                                                  ? () {
                                                      var data = state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .likes
                                                          .where((element) =>
                                                              element.userId ==
                                                              userId);

                                                      context
                                                          .read<
                                                              UnlikePostCubit>()
                                                          .createUnLike(data
                                                              .first.likeId);
                                                      print(data.first.likeId);
                                                    }
                                                  : () {
                                                      context
                                                          .read<LikesCubit>()
                                                          .createLike(state
                                                              .postsList
                                                              .first
                                                              .data[index]
                                                              .postId);
                                                    },
                                              child: state.postsList.first
                                                      .data[index].likes
                                                      .any((element) =>
                                                          element.userId ==
                                                          userId)
                                                  ? const Icon(
                                                      CupertinoIcons.heart_fill,
                                                      color: Colors.red,
                                                    )
                                                  : const Icon(
                                                      CupertinoIcons.heart,
                                                      color: Colors.black,
                                                    ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              '${state.postsList.first.data[index].likes.length}',
                                              style: AppTextStyle
                                                  .normalFontTextStyle,
                                            ),
                                            SizedBox(width: 20.w),
                                            IconButton(
                                              onPressed: () {
                                                AppNavigator.goToPage(
                                                  context: context,
                                                  screen: CommentScreen(
                                                    postId: state
                                                        .postsList
                                                        .first
                                                        .data[index]
                                                        .postId
                                                        .toString(),
                                                  ),
                                                );
                                              },
                                              icon: Image.asset(
                                                ImageAssets.messageImage,
                                                height: 20.h,
                                              ),
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                                '${state.postsList.first.data[index].comments.length}',
                                                style: AppTextStyle
                                                    .normalFontTextStyle),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: 'Liked by ',
                                                    style: AppTextStyle
                                                        .likeByTextStyle),
                                                TextSpan(
                                                    text: state
                                                            .postsList
                                                            .first
                                                            .data[index]
                                                            .likes
                                                            .isNotEmpty
                                                        ? '${state.postsList.first.data[index].likes.first.username}'
                                                        : 'None',
                                                    style: AppTextStyle
                                                        .likeByTextStyle),
                                                state
                                                            .postsList
                                                            .first
                                                            .data[index]
                                                            .likes
                                                            .length >
                                                        1
                                                    ? TextSpan(
                                                        text:
                                                            ' and ${state.postsList.first.data[index].likes.length} others',
                                                        style: AppTextStyle
                                                            .likeByTextStyle)
                                                    : const TextSpan(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    CommentScreen(
                                                      postId: state
                                                          .postsList
                                                          .first
                                                          .data[index]
                                                          .postId,
                                                    )));
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Opacity(
                                              opacity: 0.50,
                                              child: Text(
                                                  'View all ${state.postsList.first.data[index].comments.length} comments',
                                                  style: AppTextStyle
                                                      .likeByTextStyle),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                  } else if (state is GetPostFailed) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        const Center(child: Text('No Post to display')),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        const LoadingWidget()
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet(context) {
    List<String> editProfileOptionList = ["Take Photo", "Choose Photo"];
    List<IconData> editProfileOptionIconsList = [
      Icons.camera_alt_rounded,
      Icons.image
    ];
    File? image;
    final TextEditingController _captionController = TextEditingController();
    int _currentValue = 3;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      enableDrag: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          void pickImage(int index) async {
            final ImagePicker picker = ImagePicker();
            XFile? pickedImage;

            if (index == 0) {
              pickedImage = await picker.pickImage(source: ImageSource.camera);
              if (pickedImage != null) {
                setState(() {
                  image = File(pickedImage!.path);
                });
              }
            } else {
              pickedImage = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (pickedImage != null) {
                setState(() {
                  image = File(pickedImage!.path);
                });
              }
            }
          }

          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
              ),
              padding: EdgeInsets.all(15.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Create Story",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "How long does a story long?",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      ),
                      NumberPicker(
                        itemHeight: 40,
                        decoration: BoxDecoration(
                          color: Colors
                              .transparent, // Changed color to transparent
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.grey[300]!), // Added border
                        ),
                        textStyle: const TextStyle(color: Colors.black),
                        selectedTextStyle:
                            const TextStyle(color: AppColors.primary),
                        value: _currentValue,
                        minValue: 1,
                        maxValue: 24,
                        onChanged: (value) =>
                            setState(() => _currentValue = value),
                      ),
                    ],
                  ),
                  image == null
                      ? Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(10.r)),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: editProfileOptionList.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      pickImage(index);
                                    },
                                    leading:
                                        Icon(editProfileOptionIconsList[index]),
                                    title: Text(
                                      editProfileOptionList[index],
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  index == 0
                                      ? Divider(
                                          color: Colors.grey[300],
                                        )
                                      : const SizedBox()
                                ],
                              );
                            }),
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              height: 100.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Image.file(image!),
                            ),
                          ],
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: PrimaryButtonWidget(
                        width: MediaQuery.of(context).size.width,
                        caption: 'Upload',
                        onPressed: () {
                          context.read<CreateStoryCubit>().createstory(image!,
                              _captionController.text.trim(), _currentValue);
                        }),
                  ),
                  30.height,
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  final List<PostModel> postsList;
  final int index;
  final String userId;
  const PostWidget(
      {Key? key,
      required this.postsList,
      required this.index,
      required this.userId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              postsList.first.data[index].profileImage == null
                  ? CircleAvatar(
                      radius: 20.sp,
                      child: postsList.first.data[index].username.isNotEmpty
                          ? Text(postsList.first.data[index].username
                              .toString()
                              .substring(0, 1))
                          : const Text(''),
                    )
                  : CircleAvatar(
                      radius: 20.sp,
                      backgroundImage: NetworkImage(
                          postsList.first.data[index].profileImage),
                    ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        userId == postsList.first.data[index].userId
                            ? null
                            : AppNavigator.goToPage(
                                context: context,
                                screen: ThirdPersonProfileScreen(
                                    userId: postsList.first.data[index].userId),
                              );
                      },
                      child: Text(postsList.first.data[index].username,
                          style: AppTextStyle.notificationTitleTextStyle),
                    ),
                    Text(formatDateTime(postsList.first.data[index].postTime),
                        style: AppTextStyle.normalFontTextStyle)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: PopupMenuButton<int>(
                  onSelected: (item) {
                    switch (item) {
                      case 0:
                        context
                            .read<DeletePostCubit>()
                            .deletePost(postsList.first.data[index].postId);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text('Delete')),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          postsList.first.data[index].caption != null
              ? Row(
                  children: [
                    SizedBox(
                      child: Text(postsList.first.data[index].caption!,
                          style: AppTextStyle.normalFontTextStyle),
                    ),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: 10.h,
          ),
          postsList.first.data[index].hashTags != null
              ? Row(
                  children: [
                    for (int i = 0;
                        i < postsList.first.data[index].hashTags!.length;
                        i++) ...[
                      SizedBox(
                        child: Text(
                            "#${postsList.first.data[index].hashTags![i].tagName}",
                            style: AppTextStyle.codeTextStyle),
                      ),
                    ]
                  ],
                )
              : const SizedBox(),
          SizedBox(
            height: 20.h,
          ),
          postsList.first.data[index].imageUrls.length == 1
              ? CachedNetworkImage(
                  imageUrl: postsList.first.data[index].imageUrls.first,
                  placeholder: (context, url) =>
                      const LoadingWidget(), // Empty container as a placeholder
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity, // Set the width as needed
                    height: 210, // Set the height as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(
                          8.0), // Set border radius as needed
                    ),
                  ),

                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 500),
                  fadeOutDuration: const Duration(milliseconds: 500),
                  alignment: Alignment.center,
                  repeat: ImageRepeat.noRepeat,
                  filterQuality: FilterQuality.high,

                  width: double.infinity, // Set the width as needed
                  height: 210, // Set the width as needed
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width /
                      1.1, // Set the width as needed
                  height: 210,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: postsList.first.data[index].imageUrls.length,
                    itemBuilder: (context, _index) {
                      return Container(
                        width: MediaQuery.of(context).size.width /
                            1.1, // Set the width as needed
                        height: 210, // Set the height as needed
                        margin: const EdgeInsets.only(
                            right: 2.0), // Add margin between images
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  postsList.first.data[index].imageUrls[_index],
                              placeholder: (context, url) =>
                                  const LoadingWidget(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeOutDuration:
                                  const Duration(milliseconds: 500),
                              alignment: Alignment.center,
                              repeat: ImageRepeat.noRepeat,
                              filterQuality: FilterQuality.high,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.picture_in_picture_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120.w,
                height: 20.h,
                child: Stack(
                    children: List.generate(
                        postsList.first.data[index].comments.length, (_index) {
                  return Positioned(
                      left: 20.0 * index,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: postsList.first.data[index].comments[_index]
                                    .profileImage ==
                                null
                            ? CircleAvatar(
                                radius: 10.sp,
                                child: postsList.first.data[index]
                                        .comments[_index].username.isNotEmpty
                                    ? Text(postsList.first.data[index]
                                        .comments[_index].username
                                        .toString()
                                        .substring(0, 1))
                                    : const Text(''),
                              )
                            : CircleAvatar(
                                radius: 10.sp,
                                backgroundImage: NetworkImage(postsList.first
                                    .data[index].comments[_index].profileImage),
                              ),
                      ));
                })),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: postsList.first.data[index].likes
                            .any((element) => element.userId == userId)
                        ? () {
                            var data = postsList.first.data[index].likes
                                .where((element) => element.userId == userId);

                            context
                                .read<UnlikePostCubit>()
                                .createUnLike(data.first.likeId);
                            print(data.first.likeId);
                          }
                        : () {
                            context
                                .read<LikesCubit>()
                                .createLike(postsList.first.data[index].postId);
                          },
                    child: postsList.first.data[index].likes
                            .any((element) => element.userId == userId)
                        ? const Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.red,
                          )
                        : const Icon(
                            CupertinoIcons.heart,
                            color: Colors.black,
                          ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${postsList.first.data[index].likes.length}',
                    style: AppTextStyle.normalFontTextStyle,
                  ),
                  SizedBox(width: 20.w),
                  IconButton(
                    onPressed: () {
                      AppNavigator.goToPage(
                        context: context,
                        screen: CommentScreen(
                          postId: postsList.first.data[index].postId.toString(),
                        ),
                      );
                    },
                    icon: Image.asset(
                      ImageAssets.messageImage,
                      height: 20.h,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text('${postsList.first.data[index].comments.length}',
                      style: AppTextStyle.normalFontTextStyle),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SizedBox(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Liked by ',
                          style: AppTextStyle.likeByTextStyle),
                      TextSpan(
                          text: postsList.first.data[index].likes.isNotEmpty
                              ? '${postsList.first.data[index].likes.first.username}'
                              : 'None',
                          style: AppTextStyle.likeByTextStyle),
                      postsList.first.data[index].likes.length > 1
                          ? TextSpan(
                              text:
                                  ' and ${postsList.first.data[index].likes.length} others',
                              style: AppTextStyle.likeByTextStyle)
                          : const TextSpan(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (builder) => CommentScreen(
                        postId: postsList.first.data[index].postId,
                      )));
            },
            child: Row(
              children: [
                SizedBox(
                  child: Opacity(
                    opacity: 0.50,
                    child: Text(
                        'View all ${postsList.first.data[index].comments.length} comments',
                        style: AppTextStyle.likeByTextStyle),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
