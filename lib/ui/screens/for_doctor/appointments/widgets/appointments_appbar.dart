import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class AppointmentsScreenAppbar extends StatelessWidget {
  const AppointmentsScreenAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: MyColors.blue14B,
      leading: IconButton(
        onPressed: () => DoctorBaseNavBarCtrl.find.navBarController.jumpToTab(0),
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
      title: Text(
        'Appointments'.tr,
        style: const TextStyle(color: MyColors.blue14B),
      ),
    );
  }
}
