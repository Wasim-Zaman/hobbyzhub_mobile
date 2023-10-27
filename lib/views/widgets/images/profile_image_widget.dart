import 'package:flutter/material.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;
  final bool isEditable;
  final VoidCallback? onEditClicked;
  const ProfileImageWidget({
    Key? key,
    required this.imageUrl,
    required this.isEditable,
    this.onEditClicked,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 100,
            width: 100,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 4,
                color: AppColors.borderGrey,
              ),
              image: DecorationImage(
                // will change it later from asset image to cached network image
                image: AssetImage(imageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: -5,
            right: 0,
            child: IconButton(
              onPressed: onEditClicked ?? () {},
              icon: const CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.grey,
                child: Icon(Icons.edit_outlined, size: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
