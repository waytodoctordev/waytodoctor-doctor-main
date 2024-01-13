import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class CustomShimmerLoading extends StatelessWidget {
  final double? width;
  final double radius;
  final double? height;
  final EdgeInsets? padding;
  final EdgeInsetsDirectional? margin;

  const CustomShimmerLoading({
    Key? key,
    this.width,
    required this.radius,
    this.height,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: MyColors.blue9D1,
      highlightColor: MyColors.white,
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: MyColors.blue9D1,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
