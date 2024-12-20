// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/views/widgets/appbars/basic_appbar_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbarWidget(title: "Notifications", isBackButton: true),
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      index == 0
                          ? Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text('Today',
                                  style:
                                      AppTextStyle.notificationTitleTextStyle),
                            )
                          : index.floor().isEven
                              ? Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Text('23/Oct/2023',
                                      style: AppTextStyle
                                          .notificationTitleTextStyle),
                                )
                              : SizedBox(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20.sp, // Image radius
                            backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D'),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3.h,
                              ),
                              Text('Patrick Followed you',
                                  style:
                                      AppTextStyle.notificationTitleTextStyle),
                              Text('2 minutes',
                                  style: AppTextStyle.normalFontTextStyle)
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
