import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/policy/policy_ctrl.dart';

class PolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PolicyCtrl());
  }
}
