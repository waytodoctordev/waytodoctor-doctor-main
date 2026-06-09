import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class NationalId extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const NationalId({
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
            'ID Number:'.tr,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Enter your national number as it appears on your identity card or passport'
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
            delay: const Duration(milliseconds: 150),
            child: GetBuilder<FormCtrl>(
              builder: (controller) => CustomTextField(
                controller: controller.nationalIdCtrl,
                // keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                hintText: 'ID Number'.tr,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                horizontalPadding: 20,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your ID Number".tr;
                  }
                  if (value.length != 10) {
                    return 'ID Number short'.tr;
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
