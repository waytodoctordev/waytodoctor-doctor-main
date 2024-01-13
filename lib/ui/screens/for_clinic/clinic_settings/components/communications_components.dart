import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/settings/clinic_settings_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/map.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ClinicCommunicationsComponents extends StatefulWidget {
  const ClinicCommunicationsComponents({Key? key}) : super(key: key);

  @override
  State<ClinicCommunicationsComponents> createState() =>
      _ClinicCommunicationsComponentsState();
}

class _ClinicCommunicationsComponentsState
    extends State<ClinicCommunicationsComponents> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicSettingsCtrl>(
      builder: (controller) => Form(
        key: controller.communicationFormKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 37),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'communication'.tr,
              style: const TextStyle(
                fontSize: 18,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Address'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () => Get.to(() =>  MapScreen()),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(MyImages.address, height: 120),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'clarify address'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              textInputAction: TextInputAction.next,
              controller: controller.addressCtrl,
              hintText: MySharedPreferences.address == ''
                  ? 'clarify address'.tr
                  : MySharedPreferences.address,
              horizontalPadding: 20,
              validator: (value) {
                if (value!.isEmpty) {
                  return "".tr;
                }
                if (value.length < 4) {
                  return ''.tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Text(
              'Phone number'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            CustomTextField(
              horizontalPadding: 10,
              readOnly: true,
              textInputAction: TextInputAction.next,
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
              suffixIcon: Center(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    MySharedPreferences.countryCode,
                    style: const TextStyle(color: MyColors.blue14B),
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
