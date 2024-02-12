import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FollowFollowingButtonShimmer extends StatelessWidget {
  const FollowFollowingButtonShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 56,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 56,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
