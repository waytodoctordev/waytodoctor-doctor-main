import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/check_practice_ctrl.dart';

class CheckPracticeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckPracticeCtrl());
  }
}
