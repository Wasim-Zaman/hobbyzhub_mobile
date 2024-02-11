import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder, imageBuilder, errorWidget;
  final double? height, width;
  final BoxFit? fit;
  const ImageWidget({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.height,
    this.width,
    this.imageBuilder,
    this.errorWidget,
    this.fit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      placeholder: (context, url) => placeholder ?? Container(),
      width: width,
      height: height,
      // imageBuilder: (context, imageProvider) =>
      //     imageBuilder ?? const Center(child: LoadingWidget()),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.image_outlined, size: 30),
            ),
          ),
    );
  }
}
