import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/settings/clinic_settings_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class ClinicFriday extends StatelessWidget {
  const ClinicFriday({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicSettingsCtrl>(
      builder: (controller) => SizedBox(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                'Friday'.tr,
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
                    int.parse(controller.fridayFromHour.split(':')[0]) >= 12
                        ? 'PM ${controller.fridayFromHour.split(':')[0] == '12' ? controller.fridayFromHour.split(':')[0] : int.parse(controller.fridayFromHour.split(':')[0]) - 12}:${controller.fridayFromHour.split(':')[1]}'
                        : 'AM ${controller.fridayFromHour}',
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
                    int.parse(controller.fridayToHour.split(':')[0]) >= 12
                        ? 'PM ${controller.fridayToHour.split(':')[0] == '12' ? controller.fridayToHour.split(':')[0] : int.parse(controller.fridayToHour.split(':')[0]) - 12}:${controller.fridayToHour.split(':')[1]}'
                        : 'AM ${controller.fridayToHour}',
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
                value: controller.fridayStatus,
                activeColor: MyColors.blue14B,
                onChanged: (value) => controller.getFridayStatus(value),
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
                      ClinicSettingsCtrl.find.getFridayFromHour(fullTime);
                    } else {
                      String fullTime = "$hr:$min";
                      ClinicSettingsCtrl.find.getFridayFromHour(fullTime);
                    }
                  } else {
                    if (int.parse(hr) > 12) {
                      String fullTime = "$hr:$min";
                      ClinicSettingsCtrl.find.getFridayToHour(fullTime);
                    } else {
                      String fullTime = "$hr:$min";
                      ClinicSettingsCtrl.find.getFridayToHour(fullTime);
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
