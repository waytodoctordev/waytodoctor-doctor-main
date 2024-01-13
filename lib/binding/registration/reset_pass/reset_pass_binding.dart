import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/reset_pass/step3_ctrl.dart';

class ResetPassBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPassStep3Controller());
  }
}
