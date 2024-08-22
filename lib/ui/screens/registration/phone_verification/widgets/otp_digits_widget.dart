import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/send_otp_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import '../../../../../controller/registration/update_number_ctrl.dart';
import '../../../../../utils/shared_prefrences.dart';
import 'otp_timer_widget.dart';

class OTPDigitsWidget extends StatefulWidget {
  final String phoneNum, name, email, verId;
  final int userId;

  const OTPDigitsWidget({
    Key? key,
    required this.phoneNum,
    required this.name,
    required this.email,
    required this.userId,
    required this.verId,
  }) : super(key: key);

  @override
  State<OTPDigitsWidget> createState() => _OTPDigitsWidgetState();
}

class _OTPDigitsWidgetState extends State<OTPDigitsWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController digitsCtrl = TextEditingController();

  @override
  void initState() {
    Get.put(UpdateNumberCtrl());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    digitsCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: CustomTextField(
              // onChanged: (p0) => FocusScope.of(context).nextFocus(),
              controller: digitsCtrl,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                MySharedPreferences.skipOtp == 0
                    ? LengthLimitingTextInputFormatter(4)
                    : LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return "".tr;
                }
                if (MySharedPreferences.skipOtp == 0 && value.length < 4) {
                  return "".tr;
                }
                if (MySharedPreferences.skipOtp == 1 && value.length < 6) {
                  return "".tr;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          const OtpTimerWidget(),
          const SizedBox(height: 25),
          Center(
            child: CustomElevatedButton(
              title: 'Confirm'.tr,
              onPressed: () {
                log( MySharedPreferences.skipOtp.toString());
                log(widget.phoneNum);
                if (_formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (MySharedPreferences.skipOtp == 0) {
                    SendOtpCtrl.find.fetchOtpData(
                      context: context,
                      phone:widget.phoneNum,
                      code: int.parse(digitsCtrl.text.trim()),
                    );
                  } else {
                    SendOtpCtrl.find.signInWithPhoneNumber(
                        digitsCtrl.text.toString(), context, widget.verId);
                  }
                }
              },
              // onPressed: () {
              //   if (_formKey.currentState!.validate()) {
              //     FocusManager.instance.primaryFocus?.unfocus();
              //     SendOtpCtrl.find.fetchOtpData(
              //       context: context,
              //       phone: widget.phoneNum,
              //       code: '$digitsCtrl'.trim(),
              //     );
              //   }
              // },
              color: MyColors.blue14B,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
