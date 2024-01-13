import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/specialization_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../binding/registration/specialization_binding.dart';

class SpecializationScreen extends StatefulWidget {
  const SpecializationScreen({super.key});

  @override
  State<SpecializationScreen> createState() => _SpecializationScreenState();
}

class _SpecializationScreenState extends State<SpecializationScreen> {
  @override
  void initState() {
    Get.put(FormCtrl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<SpecializationCtrl>(
          init: SpecializationCtrl(),
          builder: (controller) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
              child: Column(
                // physics: const BouncingScrollPhysics(),
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Center(
                    child: Text(
                      MySharedPreferences.isDoctor
                          ? 'Specialization certificate'.tr
                          : 'Professional license'.tr,
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
                  const SizedBox(height: 20),
                  Text(
                    MySharedPreferences.isDoctor
                        ? 'Please attach a copy of the Specialization certificate.'
                            .tr
                        : 'Please attach a copy of the Professional license.'
                            .tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The user bears all legal responsibility for the validity of the data entered in our system.'
                        .tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    MySharedPreferences.isDoctor
                        ? 'Specialization certificate'.tr
                        : 'Professional license'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    MySharedPreferences.isDoctor
                        ? 'Please attach a copy of the Specialization certificate.'
                            .tr
                        : 'Please attach a copy of the Professional license.'
                            .tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 50),
                          Container(
                            height: 88,
                            decoration: const BoxDecoration(
                                color: MyColors.blue14B,
                                shape: BoxShape.circle),
                            width: 88,
                            child: IconButton(
                              onPressed: () {
                                MySharedPreferences.isProfileImage = false;
                                controller.getFile(context);
                              },
                              icon: SvgPicture.asset(
                                MyIcons.clip,
                                height: 30,
                                width: 30,
                                color: MyColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                        controller.isAttachmentAdded.value?
                          SizedBox(
                            width: Get.width,
                                 height: Get.height *.30,
                                 child:
                             Image.asset(
                                   width: Get.width, // Adjust the size as needed
                                   height: Get.height,//213231342
                                   MySharedPreferences.isDoctor
                                       ? controller.specializationCertificate.path
                                       : controller.professionalLicense.path,

                                   fit: BoxFit.cover,
                                 )
                             ):const SizedBox(),
                          //

                        ],
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    title: 'Next'.tr,
                    onPressed: () {
                      if (controller.isAttachmentAdded.value) {
                        MySharedPreferences.professionalLicense =
                            controller.professionalLicense;
                        Get.to(() => const SpecializationEndScreen(),
                            binding: SpecializationBinding());
                        controller.checkSpecialization(context: context);
                      } else {
                        AppConstants().showMsgToast(
                          context,
                          msg: MySharedPreferences.isDoctor
                              ? 'Please attach a copy of the Specialization certificate.'
                                  .tr
                              : 'Please attach a copy of the Professional license.'
                                  .tr,
                        );
                      }
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
