import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/reset_pass/step1_ctrl.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPassStep1Controller());
  }
}
