// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/utils/app_navigator.dart';
import 'package:hobbyzhub/views/group/group_messaging_screen.dart';
import 'package:hobbyzhub/views/widgets/appbars/back_appbar_widget.dart';
import 'package:hobbyzhub/views/widgets/buttons/primary_button.dart';

class AddGroupMembers extends StatefulWidget {
  const AddGroupMembers({super.key});

  @override
  State<AddGroupMembers> createState() => _AddGroupMembersState();
}

class _AddGroupMembersState extends State<AddGroupMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BackAppbarWidget(),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Text(
                'Group Admin',
                style: TextStyle(
                  color: Color(0xFF181818),
                  fontSize: 24,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.h,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/52x52"),
                          fit: BoxFit.cover,
                        ),
                        shape: OvalBorder(),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Text(
                            'Harry Styles',
                            style: TextStyle(
                              color: Color(0xFF000D07),
                              fontSize: 16,
                              fontFamily: 'Jost',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Group Admin',
                          style: TextStyle(
                            color: Color(0xFF797C7B),
                            fontSize: 12,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 160.w),
                SizedBox(
                    width: 52.w,
                    height: 52.h,
                    child: Image.asset(ImageAssets.addNewPersonImage)),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              child: Text(
                'Invite Members',
                style: TextStyle(
                  color: Color(0xFF181818),
                  fontSize: 24,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns in the grid
                    crossAxisSpacing: 8.0, // Spacing between columns
                    mainAxisSpacing: 8.0, // Spacing between rows
                  ),
                  itemCount: 10, // Number of items in your data list
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://via.placeholder.com/70x70"),
                              fit: BoxFit.cover,
                            ),
                            shape: OvalBorder(),
                          ),
                        ),
                        Positioned(
                          left: 46.w,
                          top: 46.h,
                          child: Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF0F3F5),
                              shape: OvalBorder(
                                side: BorderSide(
                                    width: 1.50, color: Colors.white),
                              ),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            PrimaryButtonWidget(
                caption: "Finish",
                onPressed: () {
                  groupCreationSheet(context);
                }),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}

void groupCreationSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: EdgeInsets.all(50.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                ImageAssets.groupCreationImage,
              ),
              Text(
                'Hikers Community',
                style: TextStyle(
                  color: Color(0xFF394851),
                  fontSize: 24,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Text(
                'You Have Successfully Created a Group!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF777A95),
                  fontSize: 20,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              PrimaryButtonWidget(
                  caption: "Continue",
                  onPressed: () {
                    AppNavigator.goToPage(
                        context: context, screen: GroupMessagingScreen());
                  })
            ],
          ),
        );
      });
}
