import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/otp_timer_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/update_number_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/prefix_icon.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  late TextEditingController phoneNumberCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneNumberCtrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    phoneNumberCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Edit phone number'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: phoneNumberCtrl,
                  hintText: 'Phone number'.tr,
                  // textAlign: TextAlign.end,
                  textDirection: TextDirection.ltr,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                        MySharedPreferences.countryDigits),
                    // LengthLimitingTextInputFormatter(9),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  horizontalPadding: 10,
                  // keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter phone number".tr;
                    }
                    if (value.length < MySharedPreferences.countryDigits) {
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
                  )),
              const SizedBox(height: 22),
              Center(
                child: GetBuilder<OTPTimerCtrl>(
                  builder: (controller) => CustomElevatedButton(
                    title: 'Send code'.tr,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        MySharedPreferences.userNumber =
                            '${MySharedPreferences.countryCode}${phoneNumberCtrl.text}';
                        UpdateNumberCtrl.find
                            .fetchUpdateNumber(
                          phone:
                              '${MySharedPreferences.countryCode}${phoneNumberCtrl.text}',
                          context: context,
                          userID: MySharedPreferences.userId.toString(),
                        )
                            .whenComplete(
                          () {
                            Get.back();
                            controller.counter.value = 60;
                          },
                        );
                        // ResendOtpCtrl.find
                        //     .resendOtp(
                        //   context: context,
                        //   userId: MySharedPreferences.id,
                        //   phone: phoneNumberCtrl.text,
                        // )
                        //     .whenComplete(
                        //   () {
                        //     Get.back();
                        //     controller.counter.value = 60;
                        //   },
                        // );
                      }
                    },
                    color: MyColors.blue14B,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: CustomElevatedButton(
                  title: 'Cancel'.tr,
                  textColor: MyColors.blue14B,
                  onPressed: () {
                    Get.back();
                  },
                  color: MyColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
