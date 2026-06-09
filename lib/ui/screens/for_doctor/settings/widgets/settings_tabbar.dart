import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/settings/settings_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class DoctorSettingsTabBar extends StatelessWidget {
  const DoctorSettingsTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: GetBuilder<SettingsCtrl>(
        builder: (controller) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 37),
          physics: const BouncingScrollPhysics(),
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(width: 5),
          itemBuilder: (context, index) => CustomElevatedButton(
            title: controller.settingsTabBarItems[index].tr,
            width: double.infinity,
            textSize: 12,
            color: controller.currentTabBarIndex != index ? MyColors.white : MyColors.blue14B,
            textColor: controller.currentTabBarIndex == index ? MyColors.white : MyColors.blue14B,
            onPressed: () {
              controller.getCurrentTabbarIndex(index);
              controller.changeSettingsPage(index);
            },
          ),
        ),
      ),
    );
  }
}
