import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/plans/plans_binding.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/plans_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../binding/registration/specialization_binding.dart';
import '../specialization_certificate/specialization_certificate_screen.dart';

class RegistrationEnd extends StatelessWidget {
  const RegistrationEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(270 / 360),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(3),
                    child: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Center(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(color: MyColors.grey7f8, borderRadius: BorderRadius.circular(26)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: -60,
                                child: CircleAvatar(
                                    radius: 70,
                                    backgroundColor: MyColors.white,
                                    child: SvgPicture.asset(
                                      MyIcons.appointmentDone,
                                      height: 100,
                                      width: 100,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          'Your account has been created successfully'.tr,
                          style: const TextStyle(
                            color: MyColors.blue14B,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Go to the next step to continue creating your account as a doctor in our medical network.'.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: MyColors.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        CustomElevatedButton(
                          title: 'Subscriptions'.tr,
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            MySharedPreferences.lastScreen = 'RegistrationEnd';
                            // Get.to(const SpecializationScreen(),binding: SpecializationBinding());
                            Get.to(() => const PlansScreen(), binding: PlansBinding());
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
