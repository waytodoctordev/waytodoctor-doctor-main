import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/privcy/privcy_ctrl.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyCtrl());
  }
}
