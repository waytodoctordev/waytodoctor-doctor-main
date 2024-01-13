import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class AppointmentNotesComponent extends StatelessWidget {
  const AppointmentNotesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes : '.tr,
          style: const TextStyle(
            color: MyColors.blue14B,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Dear user, if you have any inquiries or notes or would like to amend the appointment. Please contact the doctor\'s office, wishing you good health and wellness.'.tr,
          textAlign: TextAlign.start,
          style: const TextStyle(
            color: MyColors.textColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
