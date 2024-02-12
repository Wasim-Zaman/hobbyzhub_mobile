import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hobbyzhub/global/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class PrivateChatTileShimmer extends StatelessWidget {
  const PrivateChatTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: AppColors.lightGrey,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              bottom: 20.h,
              left: 5.w,
              right: 5.w,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProfileShimmer(),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleShimmer(),
                      SizedBox(height: 5.h),
                      _buildSubtitleShimmer(),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                _buildTimeAgoShimmer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileShimmer() {
    return Container(
      width: 45.w,
      height: 45.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  Widget _buildTitleShimmer() {
    return Container(
      height: 20.h,
      width: 150.w,
      color: Colors.white,
    );
  }

  Widget _buildSubtitleShimmer() {
    return Container(
      height: 20.h,
      width: 250.w,
      color: Colors.white,
    );
  }

  Widget _buildTimeAgoShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 80.w,
          height: 15.h,
          color: Colors.white,
        ),
        SizedBox(height: 10.h),
        Container(
          width: 20.w,
          height: 20.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
