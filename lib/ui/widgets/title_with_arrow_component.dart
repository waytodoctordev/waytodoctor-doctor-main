import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class TitleWithArrowComponent extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool withArrow;

  const TitleWithArrowComponent({
    super.key,
    required this.title,
    this.onPressed,
    this.withArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.tr,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.blue14B,
            ),
          ),
          withArrow
              ? MySharedPreferences.language == 'ar'
                  ? IconButton(
                      onPressed: onPressed,
                      icon: SvgPicture.asset(
                        MyIcons.arrowSmallLeft,
                        height: 12,
                        width: 14,
                        color: MyColors.blue14B,
                      ),
                    )
                  : RotationTransition(
                      turns: const AlwaysStoppedAnimation(180 / 360),
                      child: IconButton(
                        onPressed: onPressed,
                        icon: SvgPicture.asset(
                          MyIcons.arrowSmallLeft,
                          height: 12,
                          width: 14,
                          color: MyColors.blue14B,
                        ),
                      ),
                    )
              : const SizedBox(),
        ],
      ),
    );
  }
}
