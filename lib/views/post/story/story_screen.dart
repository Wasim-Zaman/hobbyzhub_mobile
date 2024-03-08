// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:story_view/story_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class StoryScreen extends StatefulWidget {
  final List<String> images;
  final String userName;
  final DateTime creationTime;

  StoryScreen(
      {required this.images,
      required this.userName,
      required this.creationTime});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];
  String? when = "";

  @override
  void initState() {
    widget.images.forEach((story) {
      storyItems.add(StoryItem.pageImage(
        url: story,
        controller: controller,
        duration: Duration(
          seconds: (30).toInt(),
        ),
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          StoryView(
            storyItems: storyItems,
            controller: controller,
            onComplete: () {
              Navigator.of(context).pop();
            },
            onVerticalSwipeComplete: (v) {
              if (v == Direction.down) {
                Navigator.pop(context);
              }
            },
          ),
          Container(
            padding: EdgeInsets.only(
              top: 90,
              left: 16,
              right: 16,
            ),
            child: _buildProfileView(),
          )
        ],
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    return timeago.format(now.subtract(difference), locale: 'en');
  }

  Widget _buildProfileView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 24,
          child:
              Text("${widget.userName.substring(0, 2).capitalizeEachWord()}"),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widget.userName}",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                formatDateTime(widget.creationTime),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
