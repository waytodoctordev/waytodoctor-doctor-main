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

import '../../../../../controller/for_center/center_ctrl.dart';
import 'center_signup_screen.dart';
import '../../../registration/sign_up/sign_up_screen.dart';

class CenterSignInScreen extends StatefulWidget {
  const CenterSignInScreen({Key? key}) : super(key: key);

  @override
  State<CenterSignInScreen> createState() => _CenterSignInScreenState();
}

class _CenterSignInScreenState extends State<CenterSignInScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CenterCtrl centerCtrl= Get.put(CenterCtrl());
  SignInCtrl signInCtrl= Get.find<SignInCtrl>();
  late TextEditingController phoneNumberController ;

  @override
  void initState() {
    phoneNumberController = centerCtrl.phoneNumberCtrl;
    MySharedPreferences.isDoctor=false;
    super.initState();
  }

  @override
  void dispose() {
    centerCtrl.phoneNumberCtrl.clear();
    centerCtrl.passwordCtrl.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CenterCtrl>(
      builder: (controller) => Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            /// phone number
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
                controller: phoneNumberController,
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
                    child:Obx(() =>  Text(
                      signInCtrl.currentCountryCode.value,
                      style: const TextStyle(color: MyColors.blue14B),
                    ),)
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
                controller: centerCtrl.passwordCtrl,
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
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 350),
              child: Align(
                alignment: MySharedPreferences.language == 'ar'
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.to(() => const ForgetPasswordScreen(),
                      binding: ForgetPasswordBinding()),
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
            Center(
              child: FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 450),
                child: CustomElevatedButton(
                  title: 'Sign in'.tr,
                  radius: 24,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      CenterCtrl.find.fetchCenterLoginData(
                        phone:controller.phoneNumberCtrl.text.trim(),//MySharedPreferences.countryCode+
                        password: controller.passwordCtrl.text.trim(),
                        context: context,
                      );}
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
                    child: Text(
                        'Create an account'.tr
                    ),
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
                centerCtrl.phoneNumberCtrl.clear();
                centerCtrl.passwordCtrl.clear();
                Get.to(() => const CenterSignUpScreen());

              },
            ),
          ],
        ),
      ),
    );
  }
}
