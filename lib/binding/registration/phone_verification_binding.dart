import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/otp_timer_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/resend_otp_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/send_otp_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/update_number_ctrl.dart';

class PhoneVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OTPTimerCtrl());
    Get.lazyPut(() => ResendOtpCtrl());
    Get.lazyPut(() => SendOtpCtrl());
    Get.lazyPut(() => UpdateNumberCtrl(), fenix: true);
  }
}
