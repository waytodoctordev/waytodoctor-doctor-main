import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_up_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

import '../../../../model/categories/categories_model.dart';
import '../../../../model/center/category_centers.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../common/category_center_component.dart';
import '../../../forms/form_components/address.dart';
import '../../for_center/components/categories_component.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController userNameCtrl;
  late TextEditingController passwordCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController confirmPasswordCtrl;
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // CenterCtrl centerCtrl = Get.put(CenterCtrl());
  @override
  void initState() {
    userNameCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   CenterCtrl.find.getCategoriesList(context: context);
    // });
    super.initState();
  }

  @override
  void dispose() {
    userNameCtrl.dispose();
    passwordCtrl.dispose();
    emailCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }
 final String centerName='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.only(top: 40, right: 37, left: 37),
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(270 / 360),
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.all(3),
                    child: SvgPicture.asset(
                      MyIcons.angleSmallRight,
                      color: MyColors.blue14B,
                    ),
                  ),
                ),
              ),
            ),
            const HeaderLogo(),
            const SizedBox(height: 30),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 150),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                controller: userNameCtrl,
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
            const SizedBox(height: 5),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 300),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                controller: emailCtrl,
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
            const SizedBox(height: 5),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 450),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
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
            const SizedBox(height: 5),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 600),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                controller: confirmPasswordCtrl,
                hintText: "Confirm Password".tr,
                validator: (value) {
                  if (value != passwordCtrl.text) {
                    return 'Password does not match'.tr;
                  }
                  if (value!.length < 4) {
                    return "Password too short".tr;
                  }
                  if (value.isEmpty) {
                    return "Enter your password".tr;
                  }
                  return null;
                },
                obscureText: true,
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.unlock),
              ),
            ),
            const SizedBox(height: 5),


          ],
        ),
      )),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 20, right: 37, left: 37),
        child: CustomElevatedButton(
          title: 'Next'.tr,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              SignUpCtrl().fetchDoctorSignUpData(
                email: emailCtrl.text.trim(),
                password: passwordCtrl.text.trim(),
                name: userNameCtrl.text.trim(),
                context: context,
              );
            }
          },
          color: MyColors.blue14B,
        ),
      ),
    );
  }
}
