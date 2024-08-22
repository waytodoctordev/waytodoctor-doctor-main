import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/registration/update_number_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/heder_logo.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../controller/registration/reset_pass/step1_ctrl.dart';
import '../../../../controller/registration/send_otp_ctrl.dart';
import '../phone_verification/phone_verification_screen.dart';

class PhoneSignUpScreen extends StatefulWidget {
  const PhoneSignUpScreen({Key? key}) : super(key: key);

  @override
  State<PhoneSignUpScreen> createState() => _PhoneSignUpScreenState();
}

class _PhoneSignUpScreenState extends State<PhoneSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    Get.put(SendOtpCtrl());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      UpdateNumberCtrl.find.getCountriesList(context: context);
    });

    super.initState();
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
            padding: const EdgeInsets.only(top: 20, right: 37, left: 37),
            children: [
              Align(
                alignment: MySharedPreferences.language == 'ar'
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: MySharedPreferences.language == 'ar'
                      ? RotationTransition(
                          turns: const AlwaysStoppedAnimation(270 / 360),
                          child: SvgPicture.asset(
                            MyIcons.angleSmallRight,
                            height: 7,
                            width: 7,
                            color: MyColors.blue14B,
                          ),
                        )
                      : RotationTransition(
                          turns: const AlwaysStoppedAnimation(90 / 360),
                          child: SvgPicture.asset(
                            MyIcons.angleSmallRight,
                            height: 7,
                            width: 7,
                            color: MyColors.blue14B,
                          ),
                        ),
                ),
              ),
              const HeaderLogo(),
              const SizedBox(height: 60),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Confirm phone number'.tr,
                  style: const TextStyle(
                    fontSize: 20,
                    color: MyColors.blue14B,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Please select the country code and enter your phone number'
                      .tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: MyColors.blue14B,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 300),
                child: GetBuilder<UpdateNumberCtrl>(
                  builder: (controller) => CustomTextField(
                    textInputAction: TextInputAction.next,
                    hintText: controller.currentCountry,
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
                                        controller.countries![value].digits!,
                                        controller.countries![value].skipOtp!);
                                  },
                                  itemExtent: 28.0,
                                  children: controller.countries!.map(
                                    (item) {
                                      return Center(
                                        child: Text(
                                          item.name.toString(),
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
                ),
              ),
              const SizedBox(height: 15),
              FadeInDown(
                from: 6,
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 400),
                child: GetBuilder<UpdateNumberCtrl>(
                  builder: (controller) => CustomTextField(
                    textInputAction: TextInputAction.next,
                    controller: controller.phoneNumberCtrl,
                    hintText: 'Phone number'.tr,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(
                          controller.currentCountryDigit),
                      // LengthLimitingTextInputFormatter(9),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    horizontalPadding: 10,
                    // keyboardType: TextInputType.phone,
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
                          controller.currentCountryCode,
                          style: const TextStyle(color: MyColors.blue14B),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 67),
              Center(
                child: FadeInDown(
                  from: 6,
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 500),
                  child: CustomElevatedButton(
                    title: 'Send code'.tr,
                    onPressed: () {

                      print(MySharedPreferences.userNumber);
                      print('${UpdateNumberCtrl.find.currentCountryCode}'
                          '${UpdateNumberCtrl.find.phoneNumberCtrl.text}');
                      // print(MySharedPreferences.skipOtp);
                      print(MySharedPreferences.id);
                      if (_formKey.currentState!.validate()) {
                        print('nancy in');
                        FocusManager.instance.primaryFocus?.unfocus();
                        MySharedPreferences.userNumber =
                        '${UpdateNumberCtrl.find.currentCountryCode}'
                            '${UpdateNumberCtrl.find.phoneNumberCtrl.text}';
                        UpdateNumberCtrl.find.fetchUpdateNumber(
                          phone: MySharedPreferences.userNumber,
                          context: context,
                          userID: MySharedPreferences.userId.toString(),
                        );


                        // ResetPassStep1Controller().fetchOtpData(
                        //     context: context,
                        //     phone:  MySharedPreferences.userNumber);

                      }

                     // if (_formKey.currentState!.validate()) {
                     //   FocusManager.instance.primaryFocus?.unfocus();
                     //   MySharedPreferences.userNumber =
                     //   '${UpdateNumberCtrl.find.currentCountryCode}${UpdateNumberCtrl.find.phoneNumberCtrl.text}';
                     //   // log(MySharedPreferences.userNumber);
                     //   UpdateNumberCtrl.find.fetchUpdateNumber(
                     //     phone: MySharedPreferences.userNumber,
                     //     context: context,
                     //     userID: MySharedPreferences.userId.toString(),
                     //   );
                     // }
                    },
                    color: MyColors.blue14B,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
