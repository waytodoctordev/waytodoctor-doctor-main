import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/edit_accountr_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PasswordComponent extends StatefulWidget {
  const PasswordComponent({Key? key}) : super(key: key);

  @override
  State<PasswordComponent> createState() => _PasswordComponentState();
}

class _PasswordComponentState extends State<PasswordComponent> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAccountCtrl>(
      builder: (controller) => Form(
        key: controller.passwordFormKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 150),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                controller: controller.currentPasswordCtrl,
                hintText: "Current Password".tr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password".tr;
                  }
                  if (value.length < 4) {
                    return "Password too short".tr;
                  }
                  if (value != MySharedPreferences.password) {
                    return 'Password does not match'.tr;
                  }
                  return null;
                },
                obscureText: !controller.showCurrentPassword,
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.unlock),
                suffixIcon: GestureDetector(
                  onTap: () => controller.toggleCurrentPassword(),
                  child: SvgPicture.asset(
                    !controller.showCurrentPassword
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
              delay: const Duration(milliseconds: 300),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                controller: controller.newPasswordCtrl,
                hintText: "New Password".tr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your password".tr;
                  }
                  if (value.length < 4) {
                    return "Password too short".tr;
                  }
                  if (value == MySharedPreferences.password) {
                    return "Please enter a new password".tr;
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
                controller: controller.confirmPasswordCtrl,
                hintText: "Confirm Password".tr,
                validator: (value) {
                  if (value != controller.newPasswordCtrl.text) {
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
      ),
    );
  }
}
