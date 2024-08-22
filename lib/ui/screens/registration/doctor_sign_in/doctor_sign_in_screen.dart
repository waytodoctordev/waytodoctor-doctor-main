import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';

import 'package:way_to_doctor_doctor/binding/registration/reset_pass/forget_password_binding.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/forget_password/reset_password_screens/screen1.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_slider_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../sign_up/sign_up_screen.dart';

class DoctorSignInScreen extends StatefulWidget {
  const DoctorSignInScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSignInScreen> createState() => _DoctorSignInScreenState();
}

class _DoctorSignInScreenState extends State<DoctorSignInScreen> {
  late TextEditingController phoneNumberCtrl;
  late TextEditingController passwordCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignInCtrl controller = Get.find<SignInCtrl>();
  @override
  void initState() {
    // MySharedPreferences.lastScreen = '';
    // SignInCtrl.find.getCountriesList();
    MySharedPreferences.isDoctor = true;

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
                textInputAction: TextInputAction.next,
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

            ///forget your password
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 350),
              child: Align(
                alignment: MySharedPreferences.language == 'ar'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // print( controller.currentCountryCode  );
                    MySharedPreferences.countryCode =
                        controller.currentCountryCode.value;
                    Get.to(() => const ForgetPasswordScreen(),
                        binding: ForgetPasswordBinding());
                  },
                  child: Text(
                    'forget your password ?'.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            ///SIGN IN BUTTON
            Center(
              child: FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: CustomElevatedButton(
                  title: 'Sign in'.tr,
                  radius: 24,
                  onPressed: () {
                    String phone =
                        '${MySharedPreferences.countryCode}${phoneNumberCtrl.text.trim()}';
                    MySharedPreferences.countryCode =
                        controller.currentCountryCode.value;
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      SignInCtrl.find.fetchDoctorLoginData(
                        phone: phone,
                        password: passwordCtrl.text.trim(), // 1234
                        context: context,
                      );
                    }
                  },
                  color: MyColors.blue14B,
                ),
              ),
            ),

            const SizedBox(height: 20),
            SlideAction(
              trackBuilder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text('Create an account'.tr),
                  ),
                );
              },
              thumbBuilder: (context, state) {
                return Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: MyColors.blue14B,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              action: () {
                MySharedPreferences.isDoctor = true;
                Get.to(() => const SignUpScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
