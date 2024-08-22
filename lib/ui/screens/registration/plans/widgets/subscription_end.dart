import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../../../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../../../../binding/registration/specialization_binding.dart';
import '../../../../base/for_doctor/doctor_base_nav_bar.dart';
import '../../../for_center/screens/center_home_screen.dart';
import '../../specialization_certificate/specialization_certificate_screen.dart';

class SubscriptionEnd extends StatelessWidget {
  const SubscriptionEnd({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: Center(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        color: MyColors.grey7f8,
                        borderRadius: BorderRadius.circular(26)),
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
                          'Subscription completed successfully'.tr,
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
                            MySharedPreferences.isDoctor
                                ? 'Go to the next step to continue creating your account as a doctor in our medical network.'
                                    .tr
                                : 'Go to the next step to continue creating your account as a center.'
                                    .tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: MyColors.textColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Spacer(),
                        CustomElevatedButton(
                          title: 'continue'.tr,
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            if (MySharedPreferences.subscriptionId.isNotEmpty ) {
                              if (MySharedPreferences.isDoctor) {
                                Get.offAll(() => const DoctorBaseNavBar(),
                                    binding: DoctorBaseNavBarBinding());
                              } else {
                                Get.offAll( () => CenterHomeScreen(), );
                              }
                            }
                            else {
                              Get.to(() => const SpecializationScreen(),
                                  binding: SpecializationBinding());
                            }

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
