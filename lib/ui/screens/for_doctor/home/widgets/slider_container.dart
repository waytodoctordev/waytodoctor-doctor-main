import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class SliderContainer extends StatelessWidget {
  final String image;

  const SliderContainer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 172,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.blue9D1,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: CustomNetworkImage(url: image, radius: 24),
          ),
        ],
      ),
    );
  }
}
