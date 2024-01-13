import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/icons.dart';
import '../../../../../utils/shared_prefrences.dart';

class DoctorScreenlAppbar extends StatelessWidget {
  const DoctorScreenlAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsCtrl>(
      builder: (controller) => AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: MySharedPreferences.language == 'ar'
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(270 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                )
              : RotationTransition(
                  turns: const AlwaysStoppedAnimation(90 / 360),
                  child: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 7,
                    color: MyColors.blue14B,
                  ),
                ),
        ),
        leadingWidth: 80,
        title: Text(MySharedPreferences.fName),
      ),
    );
  }
}
