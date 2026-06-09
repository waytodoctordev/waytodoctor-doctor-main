import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/check_practice_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class CheckPracticeScreen extends StatefulWidget {
  const CheckPracticeScreen({super.key});

  @override
  State<CheckPracticeScreen> createState() => _CheckPracticeScreenState();
}

class _CheckPracticeScreenState extends State<CheckPracticeScreen> {
  @override
  void initState() {
    Get.put(FormCtrl());
    super.initState();
  }

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
                // physics: const BouncingScrollPhysics(),
                crossAxisAlignment: CrossAxisAlignment.start,

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
                  const SizedBox(height: 20),
                  Text(
                    'Please attach a copy of the profession practice certificate.'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'The user bears all legal responsibility for the validity of the data entered in our system.'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Profession Practice Certificate'.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please attach a copy of the profession practice certificate.'.tr,
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
                            decoration: const BoxDecoration(color: MyColors.blue14B, shape: BoxShape.circle),
                            width: 88,
                            child: IconButton(
                              onPressed: () {
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
                          Text(
                            !controller.isImageAdded ? '' : controller.image.path.split('/').last,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: MyColors.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    title: 'Next'.tr,
                    onPressed: () {
                      if (controller.isImageAdded) {
                        controller.checkPractice(context: context);
                      } else {
                        AppConstants().showMsgToast(context, msg: 'Please attach a copy of the profession practice certificate.'.tr);
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
