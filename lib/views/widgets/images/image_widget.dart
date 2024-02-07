import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hobbyzhub/views/widgets/loading/loading_widget.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder, imageBuilder, errorWidget;
  final double? height, width;
  const ImageWidget({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.height,
    this.width,
    this.imageBuilder,
    this.errorWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => placeholder ?? Container(),
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) =>
          imageBuilder ?? const Center(child: LoadingWidget()),
      errorWidget: (context, url, error) => errorWidget ?? const Placeholder(),
    );
  }
}
