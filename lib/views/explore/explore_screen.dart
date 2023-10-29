// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/views/widgets/appbars/basic_appbar_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppbarWidget(title: 'Explore', isBackButton: false),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                      //  controller: scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0x2D3C3C43)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Art',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.dialogNormal),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'People',
                  style: AppTextStyle.exploreSubHead,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 130.h,
                  child: ListView.builder(
                      // controller: scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 5.w),
                          child: Container(
                            width: 100.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: 20.h,
                                color: Color(0xCCD9D9D9),
                                child: Text(
                                  '@tom_lee',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.dialogNormal,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Hobbies',
                  style: AppTextStyle.exploreSubHead,
                ),
                SizedBox(
                  height: 20.h,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: List<Widget>.generate(25, (index) {
                    return GridTile(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
