import 'package:flutter/material.dart';
import 'package:hobbyzhub/constants/app_text_style.dart';
import 'package:hobbyzhub/global/assets/app_assets.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:hobbyzhub/models/chat/group_chat.dart';
import 'package:hobbyzhub/views/widgets/images/image_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AppSheets {
  static groupDetailsSheet(BuildContext context, {required GroupChat group}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // group image
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(10),
                child: ClipOval(
                  child: ImageWidget(
                    imageUrl: group.groupImage ?? '',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    errorWidget: Image.asset(
                      ImageAssets.createGroupImage,
                    ),
                  ),
                ),
              ),
              // group name
              Text(
                group.title.toString(),
                style: AppTextStyle.subHeading,
              ),
              // group description
              Text(
                group.groupDescription!,
                style: AppTextStyle.subcategoryUnSelectedTextStyle,
              ),
              20.height,
              Row(
                children: [
                  Text(
                    "Total Participants:",
                    style: AppTextStyle.subHeading,
                  ),
                  Expanded(child: Container()),
                ],
              ),
              10.height,
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemBuilder: (context, i) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageWidget(
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                imageUrl: group.participants![i].profileImage!),
                          ),
                        ),
                        itemCount: group.participantIds?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              ),
              // admins
              20.height,
              Row(
                children: [
                  Text(
                    "Total Admins:",
                    style: AppTextStyle.subHeading,
                  ),
                  Expanded(child: Container()),
                ],
              ),
              10.height,
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemBuilder: (context, i) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ImageWidget(
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              imageUrl: group.participants
                                      ?.where((element) => group.adminIds!
                                          .contains(element.userId))
                                      .toList()[i]
                                      .profileImage ??
                                  '',
                            ),
                          ),
                        ),
                        itemCount: group.adminIds?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
