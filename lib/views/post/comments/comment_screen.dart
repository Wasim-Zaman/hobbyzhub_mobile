// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/blocs/specific_post/specific_post_cubit.dart';
import 'package:hobbyzhub/blocs/write_comment/write_comment_cubit.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/secondary_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentScreen extends StatefulWidget {
  final String postId;

  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    return timeago.format(now.subtract(difference), locale: 'en');
  }

  @override
  void initState() {
    initCubit();
    super.initState();
  }

  initCubit() {
    context.read<SpecificPostCubit>().specificPostInformation(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteCommentCubit, WriteCommentState>(
      listener: (context, state) {
        if (state is WriteCommentSuccessfully) {
          initCubit();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: SecondaryAppBarWidget(
          title: 'Comments',
          isBackButton: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<SpecificPostCubit, SpecificPostState>(
                builder: (context, state) {
                  if (state is SpecificPostLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              state.specificPostsList.first.data.profileImage ==
                                      null
                                  ? CircleAvatar(
                                      radius: 20.sp,
                                      child: state.specificPostsList.first.data
                                              .username.isNotEmpty
                                          ? Text(state.specificPostsList.first
                                              .data.username
                                              .toString()
                                              .substring(0, 1))
                                          : Text(''),
                                    )
                                  : CircleAvatar(
                                      radius: 20.sp,
                                      backgroundImage: NetworkImage(state
                                          .specificPostsList
                                          .first
                                          .data
                                          .profileImage),
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
                                    Text(
                                        state.specificPostsList.first.data
                                            .username,
                                        style: AppTextStyle
                                            .notificationTitleTextStyle),
                                    Text(
                                        formatDateTime(state.specificPostsList
                                            .first.data.postTime),
                                        style: AppTextStyle.normalFontTextStyle)
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          state.specificPostsList.first.data.caption.isNotEmpty
                              ? Row(
                                  children: [
                                    SizedBox(
                                      child: Text(
                                          state.specificPostsList.first.data
                                              .caption,
                                          style:
                                              AppTextStyle.normalFontTextStyle),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 20.h,
                          ),
                          state.specificPostsList.first.data.imageUrls.length ==
                                  1
                              ? CachedNetworkImage(
                                  imageUrl: state.specificPostsList.first.data
                                      .imageUrls.first,
                                  placeholder: (context, url) =>
                                      LoadingWidget(), // Empty container as a placeholder
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: double
                                        .infinity, // Set the width as needed
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
                                  fadeInDuration: Duration(milliseconds: 500),
                                  fadeOutDuration: Duration(milliseconds: 500),
                                  alignment: Alignment.center,
                                  repeat: ImageRepeat.noRepeat,
                                  filterQuality: FilterQuality.high,

                                  width: double
                                      .infinity, // Set the width as needed
                                  height: 210, // Set the width as needed
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      1.1, // Set the width as needed
                                  height: 210,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.specificPostsList.first
                                        .data.imageUrls.length,
                                    itemBuilder: (context, _index) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1, // Set the width as needed
                                        height: 210, // Set the height as needed
                                        margin: EdgeInsets.only(
                                            right:
                                                2.0), // Add margin between images
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: state.specificPostsList
                                                  .first.data.imageUrls[_index],
                                              placeholder: (context, url) =>
                                                  LoadingWidget(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
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
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 120.w,
                                height: 20.h,
                                child: Stack(
                                    children: List.generate(
                                        state.specificPostsList.first.data
                                            .comments.length, (index) {
                                  return Positioned(
                                      left: 20.0 * index,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: state
                                                    .specificPostsList
                                                    .first
                                                    .data
                                                    .comments[index]
                                                    .profileImage ==
                                                null
                                            ? CircleAvatar(
                                                radius: 10.sp,
                                                child: state
                                                        .specificPostsList
                                                        .first
                                                        .data
                                                        .comments[index]
                                                        .username
                                                        .isNotEmpty
                                                    ? Text(state
                                                        .specificPostsList
                                                        .first
                                                        .data
                                                        .comments[index]
                                                        .username
                                                        .toString()
                                                        .substring(0, 1))
                                                    : Text(''),
                                              )
                                            : CircleAvatar(
                                                radius: 10.sp,
                                                backgroundImage: NetworkImage(
                                                    state
                                                        .specificPostsList
                                                        .first
                                                        .data
                                                        .comments[index]
                                                        .profileImage),
                                              ),
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
                                      '${state.specificPostsList.first.data.likes.length}',
                                      style: AppTextStyle.normalFontTextStyle),
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
                                      '${state.specificPostsList.first.data.comments.length}',
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
                                          text: 'HarryStyles',
                                          style: AppTextStyle.likeByTextStyle),
                                      TextSpan(
                                          text: ' and ',
                                          style: AppTextStyle.likeByTextStyle),
                                      TextSpan(
                                          text: '100+',
                                          style: AppTextStyle.likeByTextStyle),
                                      TextSpan(
                                          text: ' others',
                                          style: AppTextStyle.likeByTextStyle),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Row(
                            children: [
                              state.specificPostsList.first.data.profileImage ==
                                      null
                                  ? CircleAvatar(
                                      radius: 20.sp,
                                      child: state.specificPostsList.first.data
                                              .username.isNotEmpty
                                          ? Text(state.specificPostsList.first
                                              .data.username
                                              .toString()
                                              .substring(0, 1))
                                          : Text(''),
                                    )
                                  : CircleAvatar(
                                      radius: 20.sp,
                                      backgroundImage: NetworkImage(state
                                          .specificPostsList
                                          .first
                                          .data
                                          .profileImage),
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      child: TextFieldWidget(
                                          suffixIcon: GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<WriteCommentCubit>()
                                                    .writeComment(
                                                        state.specificPostsList
                                                            .first.data.postId,
                                                        _commentController.text
                                                            .trim());
                                                _commentController.clear();
                                              },
                                              child: Icon(
                                                Icons.send,
                                                color: AppColors.primary,
                                              )),
                                          labelText: "",
                                          controller: _commentController,
                                          hintText: "Type your comment"),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state
                                  .specificPostsList.first.data.comments.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 20.h),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      state
                                                  .specificPostsList
                                                  .first
                                                  .data
                                                  .comments[index]
                                                  .profileImage ==
                                              null
                                          ? CircleAvatar(
                                              radius: 20.sp,
                                              child: state
                                                      .specificPostsList
                                                      .first
                                                      .data
                                                      .comments[index]
                                                      .username
                                                      .isNotEmpty
                                                  ? Text(state
                                                      .specificPostsList
                                                      .first
                                                      .data
                                                      .comments[index]
                                                      .username
                                                      .toString()
                                                      .substring(0, 1))
                                                  : Text(''),
                                            )
                                          : CircleAvatar(
                                              radius: 20.sp,
                                              backgroundImage: NetworkImage(
                                                  state
                                                      .specificPostsList
                                                      .first
                                                      .data
                                                      .comments[index]
                                                      .profileImage),
                                            ),
                                      SizedBox(
                                        width: 20.w,
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
                                                state
                                                    .specificPostsList
                                                    .first
                                                    .data
                                                    .comments[index]
                                                    .username,
                                                style: AppTextStyle
                                                    .notificationTitleTextStyle),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            SizedBox(
                                              child: Text(
                                                state
                                                    .specificPostsList
                                                    .first
                                                    .data
                                                    .comments[index]
                                                    .message,
                                                style: AppTextStyle
                                                    .normalFontTextStyle,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                        Center(child: LoadingWidget()),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
