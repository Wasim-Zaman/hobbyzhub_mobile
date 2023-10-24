// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';

import 'package:hobbyzhub/views/post/comments/comment_screen.dart';

import 'package:hobbyzhub/views/widgets/appbars/basic_appbar_widget.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  ? Column(
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
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
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
                                                  decoration: ShapeDecoration(
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
                                    )
                                  : Column(
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
                                                  decoration: ShapeDecoration(
                                                    color: AppColors.primary,
                                                    shape: OvalBorder(
                                                      side: BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            AppColors.primary,
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
                          );
                        }),
                  )
                ],
              ),
            ),
            ListView.builder(
                itemCount: 10,
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
                            CircleAvatar(
                              radius: 20.sp, // Image radius
                              backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
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
                                  Text('Jane Smith',
                                      style: AppTextStyle.normalFontTextStyle),
                                  Text('2 minutes',
                                      style: AppTextStyle.normalFontTextStyle)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.more_horiz,
                                color: AppColors.primary,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        'This Thanksgiving, Store-bought is just fine. Head to the link in bio ',
                                    style: AppTextStyle.normalFontTextStyle),
                                TextSpan(
                                    text: '@JaneSmith',
                                    style: AppTextStyle.likeByTextStyle),
                                TextSpan(
                                    text: ' . Check my newest recipies.',
                                    style: AppTextStyle.normalFontTextStyle),
                                TextSpan(
                                    text: ' ',
                                    style: AppTextStyle.likeByTextStyle),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          height: 208.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/328x208"),
                              fit: BoxFit.fill,
                            ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(CupertinoIcons.heart),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text('247',
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
                                Text('150',
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
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => CommentScreen()));
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                child: Opacity(
                                  opacity: 0.50,
                                  child: Text('View all 57 comments',
                                      style: AppTextStyle.likeByTextStyle),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
