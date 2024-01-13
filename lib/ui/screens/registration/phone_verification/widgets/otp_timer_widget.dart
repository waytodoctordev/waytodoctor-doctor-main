import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:way_to_doctor_doctor/controller/registration/otp_timer_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/resend_otp_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../../controller/registration/update_number_ctrl.dart';

class OtpTimerWidget extends StatelessWidget {
  const OtpTimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPTimerCtrl>(
      builder: (controller) {
        if (controller.counter.value == 0) {
          return Center(
            child: TextButton(
              onPressed: () {
                if (MySharedPreferences.skipOtp == 0) {
                  ResendOtpCtrl.find.resendOtp(
                    context: context,
                    userId: MySharedPreferences.id,
                    phone: MySharedPreferences.userNumber,
                  );
                } else {
                  UpdateNumberCtrl.find.verifyPhoneNumber(
                      context, MySharedPreferences.userNumber);
                }
                controller.counter.value = 60;
              },
              child: Text(
                'Resend'.tr,
                style: const TextStyle(
                  fontSize: 14,
                  color: MyColors.blue14B,
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 50,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '${'Resend after'.tr} ${controller.counter.value} ${"seconds".tr}',
                    style: GoogleFonts.tajawal(
                      fontSize: 16,
                      color: MyColors.blue14B,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
