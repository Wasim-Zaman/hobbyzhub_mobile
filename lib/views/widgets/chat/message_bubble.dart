import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/models/message/message.dart';
import 'package:hobbyzhub/models/message/message_model.dart';
import 'package:hobbyzhub/utils/app_date.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class MessageBubble extends StatelessWidget {
  final String imageUrl;
  final MessageModel message; // Replace with your actual Message class
  final String myUserId;

  const MessageBubble({
    super.key,
    required this.message,
    required this.myUserId,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = message.metadata?.fromUserId == myUserId;
    var dateTime = AppDate.parseTimeStringToDateTime(
        message.metadata!.dateTimeSent.toString());

    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 50 : 0,
        right: isMe ? 0 : 50,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: ImageWidget(
                imageUrl: imageUrl,
                height: 50.h,
                width: 50.w,
                errorWidget: Image.asset(ImageAssets.profileImage),
              ).visible(!isMe),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(32),
                      topRight: const Radius.circular(32),
                      bottomLeft: isMe
                          ? const Radius.circular(32)
                          : const Radius.circular(0),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    message.messageString
                        .toString(), // Replace with your actual text field
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                    softWrap: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                  ),
                  child: Text(
                    // i want to display hour, minute and am or pm along with 12 hours formate
                    // '${dateTime.hour}:${dateTime.minute} ${dateTime.hour > 12 ? 'PM' : 'AM'}',
                    '${dateTime.hour}:${dateTime.minute}',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupMessageBubble extends StatelessWidget {
  final Message message; // Replace with your actual Message class
  final String myUserId;
  final GroupChat group;

  const GroupMessageBubble({
    super.key,
    required this.message,
    required this.myUserId,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = message.metadata?.sender == myUserId;
    // DateTime dateTime = message.timeStamp!.toDate();

    return Container(
      margin: EdgeInsets.only(
        left: isMe ? 50 : 0,
        right: isMe ? 0 : 50,
      ),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: ImageWidget(
                imageUrl: group.participants!.firstWhere((element) {
                      return element.userId == message.metadata!.sender;
                    }).profileImage ??
                    "",
                fit: BoxFit.cover,
                height: 50.h,
                width: 50.w,
                errorWidget: Image.asset(ImageAssets.profileImage),
              ),
            ),
          ).visible(!isMe),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  margin: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(32),
                      topRight: const Radius.circular(32),
                      bottomLeft: isMe
                          ? const Radius.circular(32)
                          : const Radius.circular(0),
                      bottomRight: isMe
                          ? const Radius.circular(0)
                          : const Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.participants!.firstWhere((element) {
                              return element.userId == message.metadata!.sender;
                            }).fullName ??
                            '',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                      ).visible(!isMe),
                      10.height.visible(!isMe),
                      Text(
                        message.message
                            .toString(), // Replace with your actual text field
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                          fontSize: 14,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    left: isMe ? 0 : 10,
                    right: isMe ? 10 : 0,
                  ),
                  child: Text(
                      // i want to display hour, minute and am or pm along with 12 hours formate
                      // '${dateTime.hour}:${dateTime.minute} ${dateTime.hour > 12 ? 'PM' : 'AM'}',
                      // '${dateTime.hour}:${dateTime.minute}',
                      ''),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
