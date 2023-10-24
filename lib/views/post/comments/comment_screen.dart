// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/views/widgets/appbars/secondary_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/text_fields/text_fields_widget.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: SecondaryAppBarWidget(title: 'Comments', isBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Padding(
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
                                style: AppTextStyle.notificationTitleTextStyle),
                            Text('2 minutes',
                                style: AppTextStyle.likeByTextStyle)
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
                              text: ' ', style: AppTextStyle.likeByTextStyle),
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
                        image:
                            NetworkImage("https://via.placeholder.com/328x208"),
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
                          Text('247', style: AppTextStyle.normalFontTextStyle),
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
                          Text('150', style: AppTextStyle.normalFontTextStyle),
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
                      CircleAvatar(
                        radius: 20.sp, // Image radius
                        backgroundImage: NetworkImage(
                            'https://w7.pngwing.com/pngs/81/570/png-transparent-profile-logo-computer-icons-user-user-blue-heroes-logo-thumbnail.png'),
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
                    height: 30.h,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: Row(
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
                                width: 20.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text('Jane Smith',
                                        style: AppTextStyle
                                            .notificationTitleTextStyle),
                                    Text('2 minutes',
                                        style: AppTextStyle.likeByTextStyle),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        'So beautiful and amazing place. I like to take next travel to patagonia.Keep update them.Cheers!',
                                        style: AppTextStyle.normalFontTextStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          CupertinoIcons.hand_thumbsup,
                                          size: 15.sp,
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text('150',
                                            style: AppTextStyle
                                                .normalFontTextStyle),
                                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
