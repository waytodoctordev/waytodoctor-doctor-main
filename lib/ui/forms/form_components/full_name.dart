import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class FullName extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const FullName({
    super.key,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GetBuilder<FormCtrl>(
        builder: (controller) {
          return ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Text(
                'Full Name'.tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Make sure to enter your full name as it appears on your ID card or passport'
                    .tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: MyColors.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: CustomTextField(
                  textInputAction: TextInputAction.next,
                  controller: controller.firstNameCtrl,
                  hintText: 'First Name'.tr,
                  horizontalPadding: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your first name".tr;
                    }
                    if (value.length < 2) {
                      return 'First name too short'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: CustomTextField(
                  controller: controller.secondNameCtrl,
                  textInputAction: TextInputAction.next,
                  hintText: 'Second Name'.tr,
                  horizontalPadding: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your second name".tr;
                    }
                    if (value.length < 2) {
                      return 'Second name too short'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 600),
                child: CustomTextField(
                  controller: controller.thirdNameCtrl,
                  textInputAction: TextInputAction.next,
                  hintText: 'Third Name'.tr,
                  horizontalPadding: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your third name".tr;
                    }
                    if (value.length < 2) {
                      return 'Third name too short'.tr;
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 700),
                child: CustomTextField(
                  controller: controller.familyNameCtrl,
                  textInputAction: TextInputAction.next,
                  hintText: 'Family Name'.tr,
                  horizontalPadding: 20,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your family name".tr;
                    }
                    if (value.length < 2) {
                      return 'Family name too short'.tr;
                    }
                    return null;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
