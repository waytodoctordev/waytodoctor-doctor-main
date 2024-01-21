import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import '../../../../../controller/registration/sign_in_ctrl.dart';
import '../../../../common/category_center_component.dart';
import '../../../../widgets/custom_network_image.dart';

class CenterSignUpScreen extends StatefulWidget {
  const CenterSignUpScreen({Key? key}) : super(key: key);

  @override
  State<CenterSignUpScreen> createState() => _CenterSignUpScreenState();
}

class _CenterSignUpScreenState extends State<CenterSignUpScreen> {
  CenterCtrl centerCtrl = Get.find<CenterCtrl>();

  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final passwordRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController phoneNumberController;
  @override
  void initState() {
    centerCtrl.passwordCtrl == TextEditingController();
    centerCtrl.getCountriesList(context:context);
    centerCtrl.centerAddressCtrl.text='';
    super.initState();
  }

  @override
  void dispose() {
    centerCtrl.userNameCtrl.clear();
    centerCtrl.passwordCtrl.clear();
    centerCtrl.phoneNumberCtrl.clear();
    centerCtrl.centerAddressCtrl.clear();
    centerCtrl.passwordCtrl.clear();
    centerCtrl.confirmPasswordCtrl.clear();
    super.dispose();
  }

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
                  onTap: () {
                    centerCtrl.phoneNumberCtrl.clear();
                    centerCtrl.passwordCtrl.clear();
                    Get.back();
                  },
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
            /// USER NAME
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 150),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                controller: centerCtrl.userNameCtrl,
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

            /// COUNTRIES
            GetBuilder<SignInCtrl>(
              builder: (controller) => Column(
                children: [
                  CustomTextField(
                  textInputAction: TextInputAction.next,
                  hintText: controller.currentCountry.tr,
                  autoValidateMode: AutovalidateMode.always,
                  readOnly: true,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return CupertinoActionSheet(
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Get.back(),
                            // isDefaultAction: true,
                            child: Text(
                              'Cancel'.tr,
                              style: GoogleFonts.tajawal(
                                fontSize: 16,
                                color: MyColors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          actions: [
                            SizedBox(
                              height: 250,
                              child: CupertinoPicker(
                                onSelectedItemChanged: (value) {
                                  controller.getCurrentCountry(
                                    controller.countries![value].name
                                        .toString(),
                                  );
                                  controller.getCurrentCountryCode(
                                    controller.countries![value].code
                                        .toString(),
                                  );
                                  controller.getCurrentCountryImage(
                                    controller.countries![value].image
                                        .toString(),
                                  );
                                  controller.getCurrentDigits(
                                      controller.countries![value].digits!);
                                },
                                itemExtent: 28.0,
                                children: controller.countries!.map(
                                      (item) {
                                    return Center(
                                      child: Text(
                                        item.name.toString().tr,
                                        style: GoogleFonts.tajawal(
                                          fontSize: 16,
                                          color: MyColors.blue14B,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  suffixIcon: SvgPicture.asset(
                    MyIcons.angleSmallRight,
                    height: 7,
                    width: 14,
                  ),
                  prefixIcon: Container(
                    width: 80,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomNetworkImage(
                          url: controller.currentCountryImage,
                          radius: 10,
                          height: 27,
                          width: 27,
                        ),
                        const VerticalDivider(
                          color: MyColors.blue14B,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                              ),
                  const SizedBox(height: 5),
                  /// PHONE NUMBER
                  FadeInDown(
                    from: 6,
                    duration: const Duration(milliseconds: 600),
                    delay: const Duration(milliseconds: 150),
                    child: CustomTextField(
                      horizontalPadding: 10,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(
                            centerCtrl.currentCountryDigit),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: centerCtrl.phoneNumberCtrl,
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
                          child: Obx(() => Text(
                            controller.currentCountryCode.value,
                            style: const TextStyle(color: MyColors.blue14B),
                          ),)
                        ),
                      ),
                    ),
                  ),
                ],
              ),),




            const SizedBox(height: 5),
            CategoryCentersComponent(),
            const SizedBox(height: 5),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 450),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
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
            const SizedBox(height: 5),
            FadeInDown(
              from: 6,
              duration: const Duration(milliseconds: 600),
              delay: const Duration(milliseconds: 600),
              child: CustomTextField(
                textInputAction: TextInputAction.next,
                horizontalPadding: 10,
                controller: centerCtrl.confirmPasswordCtrl,
                hintText: "Confirm Password".tr,
                validator: (value) {
                  if (value != centerCtrl.passwordCtrl.text) {
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
            const SizedBox(height: 30),
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
              centerCtrl.fetchCenterSignUpData(
                context: context,
                name: centerCtrl.userNameCtrl.text.trim(),
                // address: '',//centerCtrl.centerAddressCtrl.text
                phone: centerCtrl.phoneNumberCtrl.text,
                password: centerCtrl.passwordCtrl.text.trim(),
                centerCategoryId: centerCtrl.categoriesID.value.toString(),
              );
            }

          },
          color: MyColors.blue14B,
        ),
      ),
    );
  }
}
