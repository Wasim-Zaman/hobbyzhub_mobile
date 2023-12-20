// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/delete_post/delete_post_cubit.dart';
import 'package:hobbyzhub/blocs/get_post/get_post_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/post/comments/comment_screen.dart';
import 'package:hobbyzhub/views/post/story/story_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/basic_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    return timeago.format(now.subtract(difference), locale: 'en');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeletePostCubit, DeletePostState>(
      listener: (context, state) {
        if (state is DeletePostLoaded) {
          context.read<GetPostCubit>().getPostList();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: BasicAppbarWidget(title: 'Feeds', isBackButton: false),
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
                      child: ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                child: index != 0
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      StoryScreen()));
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                                      decoration:
                                                          ShapeDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://via.placeholder.com/25x25"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                          ShapeDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://via.placeholder.com/25x25"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        shape: OvalBorder(
                                                          side: BorderSide(
                                                              width: 0.50,
                                                              color: AppColors
                                                                  .primary),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text('Chris',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle
                                                    .normalFontTextStyle),
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {},
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
                                                      decoration:
                                                          ShapeDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://via.placeholder.com/70x100"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                          ShapeDecoration(
                                                        color:
                                                            AppColors.primary,
                                                        shape: OvalBorder(
                                                          side: BorderSide(
                                                            width: 0.50,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text('Your Story',
                                                textAlign: TextAlign.center,
                                                style: AppTextStyle
                                                    .normalFontTextStyle),
                                          ],
                                        ),
                                      ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
              BlocBuilder<GetPostCubit, GetPostState>(
                builder: (context, state) {
                  if (state is GetPostLoaded) {
                    return ListView.builder(
                        itemCount: state.postsList.first.data.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                : Text(''),
                                          )
                                        : CircleAvatar(
                                            radius: 20.sp,
                                            backgroundImage: NetworkImage(state
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
                                              state.postsList.first.data[index]
                                                  .username,
                                              style: AppTextStyle
                                                  .notificationTitleTextStyle),
                                          Text(
                                              formatDateTime(state.postsList
                                                  .first.data[index].postTime),
                                              style: AppTextStyle
                                                  .normalFontTextStyle)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
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
                                          PopupMenuItem<int>(
                                              value: 0, child: Text('Delete')),
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
                                    : SizedBox(),
                                SizedBox(
                                  height: 10.h,
                                ),
                                state.postsList.first.data[index].hashTags !=
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
                                    : SizedBox(),
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
                                            LoadingWidget(), // Empty container as a placeholder
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
                                        fadeInDuration:
                                            Duration(milliseconds: 500),
                                        fadeOutDuration:
                                            Duration(milliseconds: 500),
                                        alignment: Alignment.center,
                                        repeat: ImageRepeat.noRepeat,
                                        filterQuality: FilterQuality.high,

                                        width: double
                                            .infinity, // Set the width as needed
                                        height: 210, // Set the width as needed
                                      )
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                              margin: EdgeInsets.only(
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
                                                    placeholder:
                                                        (context, url) =>
                                                            LoadingWidget(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                    fit: BoxFit.cover,
                                                    fadeInDuration: Duration(
                                                        milliseconds: 500),
                                                    fadeOutDuration: Duration(
                                                        milliseconds: 500),
                                                    alignment: Alignment.center,
                                                    repeat:
                                                        ImageRepeat.noRepeat,
                                                    filterQuality:
                                                        FilterQuality.high,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons
                                                              .picture_in_picture_sharp,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 120.w,
                                      height: 20.h,
                                      child: Stack(
                                          children: List.generate(10, (i) {
                                        return Positioned(
                                            left: 20.0 * i,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  height: 20.h,
                                                  width: 20.w,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D")),
                                                      shape: BoxShape.circle)),
                                            ));
                                      })),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(CupertinoIcons.heart),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                            '${state.postsList.first.data[index].likes.length}',
                                            style: AppTextStyle
                                                .normalFontTextStyle),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Image.asset(
                                          ImageAssets.messageImage,
                                          height: 20.h,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
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
                                                text: 'HarryStyles',
                                                style: AppTextStyle
                                                    .likeByTextStyle),
                                            TextSpan(
                                                text: ' and ',
                                                style: AppTextStyle
                                                    .likeByTextStyle),
                                            TextSpan(
                                                text: '100+',
                                                style: AppTextStyle
                                                    .likeByTextStyle),
                                            TextSpan(
                                                text: ' others',
                                                style: AppTextStyle
                                                    .likeByTextStyle),
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (builder) => CommentScreen(
                                                  postId: state.postsList.first
                                                      .data[index].postId!,
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        child: Opacity(
                                          opacity: 0.50,
                                          child: Text(
                                              'View all ${state.postsList.first.data[index].comments.length} comments',
                                              style:
                                                  AppTextStyle.likeByTextStyle),
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
                        Center(child: Text('No Post to display')),
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
                        Center(child: CircularProgressIndicator()),
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
}
