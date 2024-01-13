import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/registration/specialization_binding.dart';
import 'package:way_to_doctor_doctor/controller/registration/check_practice_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/specialization_certificate_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../binding/form/form_binding.dart';
import '../../../../forms/form_screen/form_screen.dart';

class CheckPracticeEndScreen extends StatelessWidget {
  const CheckPracticeEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CheckPracticeCtrl>(
          init: CheckPracticeCtrl(),
          builder: (controller) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Check practice'.tr,
                      style: const TextStyle(
                        fontSize: 20,
                        color: MyColors.blue14B,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    height: 67,
                    decoration: BoxDecoration(
                      color: MyColors.blue9D1,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Text(
                      'Make sure to include a clear, legible photo.'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: MyColors.blue14B,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Text(
                    'Thanks'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your account is now being reviewed to verify the certificate information. You can continue to use the application without any interruption.'
                        .tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    title: 'Next'.tr,
                    onPressed: () {
                      // MySharedPreferences.formCurrentIndex = 0;
                      // MySharedPreferences.formIndicatorCurrentIndex = 0;
                      // MySharedPreferences.lastScreen = 'SpecializationScreen';
                      // // Get.to(() => const FormScreen(), binding: FormBinding());
                      //               Get.to(() => const SpecializationScreen(),
                          // binding: SpecializationBinding());
                      MySharedPreferences.lastScreen = 'FormScreen';
                      Get.to(() => const FormScreen(), binding: FormBinding());
                    },
                    color: MyColors.blue14B,
                    width: MediaQuery.of(context).size.width,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
