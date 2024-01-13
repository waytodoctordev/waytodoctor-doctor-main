import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class CustomPrefixIcon extends StatelessWidget {
  final String icon;

  const CustomPrefixIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            icon,
            height: 22,
            width: 18,
            color: MyColors.blue14B,
          ),
          const VerticalDivider(
            color: MyColors.blue14B,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
