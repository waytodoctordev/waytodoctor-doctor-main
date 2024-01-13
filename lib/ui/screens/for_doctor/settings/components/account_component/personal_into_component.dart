import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiver/pattern.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/edit_accountr_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../../controller/form/form_ctrl.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../forms/form_components/address.dart';

class PersonalInfoComponent extends StatefulWidget {
  const PersonalInfoComponent({Key? key}) : super(key: key);

  @override
  State<PersonalInfoComponent> createState() => _PersonalInfoComponentState();
}

class _PersonalInfoComponentState extends State<PersonalInfoComponent> {
  // FormCtrl formCtrl = Get.put(FormCtrl());

  // CenterCtrl centerCtrl = Get.put(CenterCtrl());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAccountCtrl>(
      builder: (controller) => Form(
        key: controller.personalFormKey,
        child: ListView(
          children: [
            /// user name
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
                  if (value.length < 2) {
                    return 'Username too short'.tr;
                  }
                  return null;
                },
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.user),
              ),
            ),
            const SizedBox(height: 10),
            /// user phone number
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
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
                suffixIcon: Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      MySharedPreferences.countryCode,
                      style: const TextStyle(color: MyColors.blue14B),
                    ),
                  ),
                ),
              ),
            ),
            /// user address details
            const SizedBox(height: 10),
            /// Center Address
          MySharedPreferences.isDoctor
              ? const SizedBox()
              :  SizedBox(
              height: Get.height * .45,
              child: Address(
                formKey: formKey,
              )),



          ],
        ),
      ),
    );
  }
}
