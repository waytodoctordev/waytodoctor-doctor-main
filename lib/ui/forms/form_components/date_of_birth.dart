import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class DateOfBirth extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const DateOfBirth({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            'Date of birth'.tr,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Enter your date of birth'.tr,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          GetBuilder<FormCtrl>(
            builder: (controller) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 150),
                      child: CustomTextField(
                        controller: controller.dayCtrl,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        hintText: 'Day'.tr,
                        horizontalPadding: 20,
                        // keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.parse(value) > 31 ||
                              int.parse(value) < 1) {
                            return "".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 300),
                      child: CustomTextField(
                        controller: controller.monthCtrl,
                        textInputAction: TextInputAction.next,
                        // keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        hintText: 'Month'.tr,
                        horizontalPadding: 20,
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.parse(value) > 12 ||
                              int.parse(value) < 1) {
                            return "".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FadeInDown(
                      from: 6,
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 450),
                      child: CustomTextField(
                        controller: controller.yearCtrl,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(4),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        // keyboardType: TextInputType.number,
                        hintText: 'Year'.tr,
                        horizontalPadding: 20,
                        validator: (value) {
                          if (value!.isEmpty ||
                              int.parse(value) > 2005 ||
                              int.parse(value) < 1930) {
                            return "".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
