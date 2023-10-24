import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class OtherProfileScreen extends StatefulWidget {
  const OtherProfileScreen({Key? key}) : super(key: key);

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 1000), () {
      showBottomSheet();
    });
    super.initState();
  }

  showBottomSheet() {
    /*
      Create a bottom sheet such that it initially covers 70 percent height
      of the screen, but when i scroll it, it takes up the full screen.

      but the bottom sheet should never be dismissed when i scroll it down.
      but it could be decreased again to 70 percent of height 
    */

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 1,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.shade300,
            //     blurRadius: 10,
            //     spreadRadius: 5,
            //   )
            // ],
            ),
        height: context.height() * 0.4,
        width: context.width(),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/login.png',
                height: 200,
                width: 200,
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                icon: Icon(Ionicons.arrow_back),
                onPressed: () {},
              ),
            )
          ],
        ),
      )),
    );
  }
}
