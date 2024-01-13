import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class ViewImageScreen extends StatelessWidget {
  final String imageUrl;
  final Object heroTag;

  const ViewImageScreen({Key? key, required this.imageUrl, required this.heroTag}) : super(key: key);

  Widget getPlaceHolder() {
    return Image.asset(
      MyImages.wayToDoctorLogo,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => getPlaceHolder(),
                errorWidget: (context, url, error) => getPlaceHolder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
