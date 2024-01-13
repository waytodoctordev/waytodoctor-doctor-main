import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomImageViewer extends StatelessWidget {
  final String image;
  const CustomImageViewer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(image),
      basePosition: Alignment.center,
      minScale: PhotoViewComputedScale.contained,
    );
  }
}
