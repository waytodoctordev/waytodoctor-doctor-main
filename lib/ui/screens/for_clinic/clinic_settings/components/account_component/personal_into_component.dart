import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/settings/clinic_settings_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class ClinicPersonalInfoComponent extends StatefulWidget {
  const ClinicPersonalInfoComponent({Key? key}) : super(key: key);

  @override
  State<ClinicPersonalInfoComponent> createState() =>
      _ClinicPersonalInfoComponentState();
}

class _ClinicPersonalInfoComponentState
    extends State<ClinicPersonalInfoComponent> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicSettingsCtrl>(
      builder: (controller) => Form(
        key: controller.personalFormKey,
        child: ListView(
          children: [
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 150),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                controller: controller.nameCtrl,
                hintText: 'Username'.tr,
                horizontalPadding: 10,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your username".tr;
                  }
                  if (value.length < 4) {
                    return 'Username too short'.tr;
                  }
                  return null;
                },
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.user),
              ),
            ),
            const SizedBox(height: 10),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                controller: controller.emailCtrl,
                hintText: 'Email'.tr,
                validator: (value) {
                  String pattern =
                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                      r"{0,253}[a-zA-Z0-9])?)*$";
                  RegExp regex = RegExp(pattern);
                  if (value!.isEmpty) {
                    return "Enter your email".tr;
                  }
                  if (!regex.hasMatch(value)) {
                    return "Please enter a valid email address".tr;
                  }
                  return null;
                },
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.att),
              ),
            ),
            const SizedBox(height: 10),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 450),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                inputFormatters: [
                  // LengthLimitingTextInputFormatter(9),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: controller.phoneNumberCtrl,
                // keyboardType: TextInputType.number,
                hintText: 'Phone number'.tr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number".tr;
                  }
                  if (value.length < 9) {
                    return "The phone number is too short.".tr;
                  }
                  return null;
                },
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.call),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
