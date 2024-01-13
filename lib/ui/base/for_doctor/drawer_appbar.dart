import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CustomAppBar extends StatelessWidget {
  final Color color;
  final String text;
  final void Function()? onPressed;

  const CustomAppBar({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 0, left: 0),
          child: IconButton(
            onPressed: onPressed,
            icon: MySharedPreferences.language == 'ar'
                ? RotationTransition(
                    turns: const AlwaysStoppedAnimation(270 / 360),
                    child: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      height: 7,
                      width: 7,
                      color: color,
                    ),
                  )
                : RotationTransition(
                    turns: const AlwaysStoppedAnimation(90 / 360),
                    child: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      height: 7,
                      width: 7,
                      color: color,
                    ),
                  ),
          ),
        ),
        const Spacer(),
        Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: color,
          ),
        ),
      ],
    );
  }
}
