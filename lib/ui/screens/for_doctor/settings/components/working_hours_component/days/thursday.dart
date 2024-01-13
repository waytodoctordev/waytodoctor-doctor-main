import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/settings/settings_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class Thursday extends StatelessWidget {
  const Thursday({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsCtrl>(
      builder: (controller) => SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Thursday'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => _showDatePicker('from', context),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyColors.blue9D1,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    int.parse(controller.thursdayFromHour.split(':')[0]) >= 12
                        ? 'PM ${controller.thursdayFromHour.split(':')[0] == '12' ? controller.thursdayFromHour.split(':')[0] : int.parse(controller.thursdayFromHour.split(':')[0]) - 12}:${controller.thursdayFromHour.split(':')[1]}'
                        : 'AM ${controller.thursdayFromHour}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => _showDatePicker('to', context),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyColors.blue9D1,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    int.parse(controller.thursdayToHour.split(':')[0]) >= 12
                        ? 'PM ${controller.thursdayToHour.split(':')[0] == '12' ? controller.thursdayToHour.split(':')[0] : int.parse(controller.thursdayToHour.split(':')[0]) - 12}:${controller.thursdayToHour.split(':')[1]}'
                        : 'AM ${controller.thursdayToHour}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Switch(
                value: controller.thursdayStatus,
                activeColor: MyColors.blue14B,
                onChanged: (value) => controller.geThursdayStatus(value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(String type, ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 200,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (val) {
                  String pickedTime =
                      val.toString().split(' ')[1].split('.000')[0];
                  String hr = pickedTime.split(':')[0];
                  String min = pickedTime.split(':')[1];
                  if (type == 'from') {
                    if (int.parse(hr) > 12) {
                      String fullTime = "$hr:$min";
                      SettingsCtrl.find.getThursdayFromHour(fullTime);
                    } else {
                      String fullTime = "$hr:$min";
                      SettingsCtrl.find.getThursdayFromHour(fullTime);
                    }
                  } else {
                    if (int.parse(hr) > 12) {
                      String fullTime = "$hr:$min";
                      SettingsCtrl.find.getThursdayToHour(fullTime);
                    } else {
                      String fullTime = "$hr:$min";
                      SettingsCtrl.find.getThursdayToHour(fullTime);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
