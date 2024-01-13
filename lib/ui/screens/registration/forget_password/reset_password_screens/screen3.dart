import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/reset_pass/step3_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ResetPasswordScreen extends StatelessWidget {
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final String phone;
  ResetPasswordScreen({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ResetPassStep3Controller>(
        builder: (controller) => Form(
          key: passwordFormKey,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.only(top: 63, right: 37, left: 37),
            children: [
              const HeaderLogo(),
              const SizedBox(height: 60),
              Text(
                "New Password".tr,
                style: const TextStyle(
                  fontSize: 20,
                  color: MyColors.blue14B,
                ),
              ),
              const SizedBox(height: 15),
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
                  obscureText: true,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.unlock),
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
                  obscureText: true,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.unlock),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<ResetPassStep3Controller>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
          child: CustomElevatedButton(
            title: 'Add'.tr,
            width: MediaQuery.of(context).size.width,
            onPressed: () {
              if (passwordFormKey.currentState!.validate()) {
                FocusManager.instance.primaryFocus?.unfocus();
                ResetPassStep3Controller.fetchResetPassStep3Data(
                    context: context,
                    phone: phone,
                    password: controller.confirmPasswordCtrl.text);
              }
            },
          ),
        ),
      ),
    );
  }
}
