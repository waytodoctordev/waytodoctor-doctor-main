import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ClinicSignInScreen extends StatefulWidget {
  const ClinicSignInScreen({Key? key}) : super(key: key);

  @override
  State<ClinicSignInScreen> createState() => ClinicSignInScreenState();
}

class ClinicSignInScreenState extends State<ClinicSignInScreen> {
  late TextEditingController phoneNumberCtrl;
  late TextEditingController passwordCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // SignInCtrl.find.getCountriesList();
    phoneNumberCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumberCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInCtrl>(
      builder: (controller) => Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 150),
              child: CustomTextField(
                horizontalPadding: 10,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(
                      controller.currentCountryDigit),
                  // LengthLimitingTextInputFormatter(9),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                controller: phoneNumberCtrl,
                // keyboardType: TextInputType.number,
                hintText: 'Phone number'.tr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone number".tr;
                  }
                  if (value.length < controller.currentCountryDigit) {
                    return "The phone number is too short.".tr;
                  }
                  return null;
                },
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.call),
                suffixIcon: Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      controller.currentCountryCode.value,
                      style: const TextStyle(color: MyColors.blue14B),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: CustomTextField(
                horizontalPadding: 10,
                textInputAction: TextInputAction.done,
                controller: passwordCtrl,
                hintText: 'Password'.tr,
                validator: (value) {
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
            const SizedBox(height: 40),
            Center(
              child: FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: CustomElevatedButton(
                  title: 'Sign in'.tr,
                  radius: 24,
                  onPressed: () {
                    MySharedPreferences.countryCode =
                        controller.currentCountryCode.value;
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      SignInCtrl.find.clinicLogin(
                        phone:
                            '${MySharedPreferences.countryCode}${phoneNumberCtrl.text.trim()}', // 0795401109
                        password: passwordCtrl.text.trim(), // 1234
                        context: context,
                      );
                    }
                  },
                  color: MyColors.blue14B,
                ),
              ),
            ),
            const SizedBox(height: 5),

            // const SizedBox(height: 40),
            // Center(
            //   child: CustomElevatedButton(
            //     title: 'Next'.tr,
            //     radius: 24,
            //     onPressed: () {
            //       MySharedPreferences.isDoctor = false;
            //       Get.to(() => const SignUpScreen());
            //     },
            //     color: MyColors.blue14B,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
