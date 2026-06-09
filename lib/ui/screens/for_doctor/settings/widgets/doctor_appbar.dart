import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../controller/for_doctor/settings/settings_ctrl.dart';

class DoctorSettingsAppbar extends StatefulWidget {
  const DoctorSettingsAppbar({super.key});

  @override
  State<DoctorSettingsAppbar> createState() => _DoctorSettingsAppbarState();
}

class _DoctorSettingsAppbarState extends State<DoctorSettingsAppbar> {
 @override
  void initState() {
   settingsCtrl= Get.find<SettingsCtrl>();
    super.initState();
  }
 late SettingsCtrl settingsCtrl;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GetBuilder<DoctorBaseNavBarCtrl>(
        builder: (controller) => IconButton(
          onPressed: () {
            controller.navBarController.jumpToTab(0);
            settingsCtrl.getCurrentTabbarIndex(0);
            settingsCtrl.changeSettingsPage(0);
          },
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
      ),
      leadingWidth: 80,
      title: Text('Clinic'.tr),
    );
  }
}
