import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/settings/settings_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class AccountComponent extends StatefulWidget {
  const AccountComponent({super.key});

  @override
  State<AccountComponent> createState() => _AccountComponentState();
}

class _AccountComponentState extends State<AccountComponent> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsCtrl>(
      builder: (controller) {
        return Form(
          key: controller.clinicUserNameFormKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.only(top: 20, right: 37, left: 37, bottom: 0),
            children: [
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: CustomTextField(
                  horizontalPadding: 20,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.call),

                  // textAlign: TextAlign.center,
                  hintText: MySharedPreferences.userNumber
                      .toString()
                      .split(MySharedPreferences.countryCode)
                      .join(),
                  readOnly: true,
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
              const SizedBox(height: 10),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: CustomTextField(
                  textInputAction: TextInputAction.next,
                  horizontalPadding: 10,
                  controller: controller.clinicPasswordCtrl,
                  hintText: "New Password".tr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    if (value.length < 4) {
                      return "Password too short".tr;
                    }

                    return null;
                  },
                  obscureText: !controller.showNewPassword,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.unlock),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.toggleNewPassword(),
                    child: SvgPicture.asset(
                      !controller.showNewPassword
                          ? MyIcons.eyClosed
                          : MyIcons.eye,
                      height: 14,
                      width: 14,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: CustomTextField(
                  textInputAction: TextInputAction.done,
                  horizontalPadding: 10,
                  controller: controller.clinicPasswordAgianCtrl,
                  hintText: "Confirm Password".tr,
                  validator: (value) {
                    if (value != controller.clinicPasswordCtrl.text) {
                      return 'Password does not match'.tr;
                    }
                    if (value!.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    if (value.length < 4) {
                      return "Password too short".tr;
                    }
                    return null;
                  },
                  obscureText: !controller.showConfirmPassword,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.unlock),
                  suffixIcon: GestureDetector(
                    onTap: () => controller.toggleConfirmPassword(),
                    child: SvgPicture.asset(
                      !controller.showConfirmPassword
                          ? MyIcons.eyClosed
                          : MyIcons.eye,
                      height: 14,
                      width: 14,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
