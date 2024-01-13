import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_action/slide_action.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CustomSliderButton extends StatelessWidget {
  final String text;
  final double textSize;
  final Function()? onPressed;
  final String icon;
  final double height;
  final double padding;
  const CustomSliderButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon = MyIcons.arrowSmallRight,
    this.textSize = 16,
    this.height = 60,
    this.padding = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      child:  SlideAction(
        trackBuilder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: textSize,
                  color: MyColors.white,
                ),
              ),
            ),
          );
        },
        thumbBuilder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: MyColors.blue14B,
              borderRadius: BorderRadius.circular(50),
            ),
            child: MySharedPreferences.language == 'ar'
                ? SizedBox(
              height: 18,
              width: 18,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: SvgPicture.asset(
                  icon,
                  color: MyColors.blue14B,
                ),
              ),
            )
                : SizedBox(
              height: 18,
              width: 18,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: SvgPicture.asset(
                  icon,
                  color: MyColors.blue14B,
                ),
              ),
            ),
          );
        },

        rightToLeft: MySharedPreferences.language == 'ar' ? true : false,
        trackHeight: height,
        action: onPressed,
      ),
    );
  }
}
