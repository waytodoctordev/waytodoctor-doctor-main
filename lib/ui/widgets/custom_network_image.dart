import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_shimmer_loading.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class CustomNetworkImage extends StatelessWidget {

  final String url;
  final double radius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final BoxFit boxFit;

  const CustomNetworkImage({
    Key? key,
    required this.url,
    required this.radius,
    this.width,
    this.height,
    this.margin,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${ApiUrl.mainUrl}/$url",
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
          ),
        ),
      ),
      placeholder: (context, url) {
        return CustomShimmerLoading(
          radius: radius,
          height: height,
          width: width,
        );
      },
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        margin: margin,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: MyColors.grey5d8,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Image.asset(
          MyImages.wayToDoctorLogo,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
