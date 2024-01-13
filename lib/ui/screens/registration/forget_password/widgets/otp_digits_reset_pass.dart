import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../controller/registration/reset_pass/step2_ctrl.dart';
import '../../../../../controller/registration/update_number_ctrl.dart';

class OTPDigitsResetPasswordWidget extends StatefulWidget {
  final String phoneNum, name, email, verId;

  final int userId, skipOtp;

  const OTPDigitsResetPasswordWidget({
    Key? key,
    required this.phoneNum,
    required this.name,
    required this.email,
    required this.userId,
    required this.verId,
    required this.skipOtp,
  }) : super(key: key);

  @override
  State<OTPDigitsResetPasswordWidget> createState() =>
      _OTPDigitsResetPasswordWidgetState();
}

class _OTPDigitsResetPasswordWidgetState
    extends State<OTPDigitsResetPasswordWidget> {
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomTextField(
              // onChanged: (p0) => FocusScope.of(context).nextFocus(),
              controller: digitsCtrl,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                widget.skipOtp == 0
                    ? LengthLimitingTextInputFormatter(4)
                    : LengthLimitingTextInputFormatter(6),
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return "".tr;
                }
                if (widget.skipOtp == 0 && value.length < 4) {
                  return "".tr;
                }
                if (widget.skipOtp == 1 && value.length < 6) {
                  return "".tr;
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          // const OtpTimerResetPassWidget(),
          const SizedBox(height: 25),
          Center(
            child: CustomElevatedButton(
              title: 'Confirm'.tr,
              onPressed: () {
                print(widget.skipOtp);
                if (_formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (widget.skipOtp == 0) {
                    ResetPassStep2Controller.fetchResetPassStep2Data(
                      context: context,
                      phone: MySharedPreferences.countryCode+widget.phoneNum,
                      code: digitsCtrl.text.trim(),
                    );
                  } else {
                    // log(widget.verId);
                    ResetPassStep2Controller().signInWithPhoneNumber(
                        digitsCtrl.text.toString(),
                        context,
                        widget.verId,
                        widget.phoneNum);
                  }
                }
              },
              color: MyColors.blue14B,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
