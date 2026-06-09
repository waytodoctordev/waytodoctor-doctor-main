import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/otp_timer_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/resend_otp_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/reset_pass/step2_ctrl.dart';

class CodeVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPassStep2Controller());
    Get.lazyPut(() => OTPTimerCtrl());
    Get.lazyPut(() => ResendOtpCtrl());
  }
}
