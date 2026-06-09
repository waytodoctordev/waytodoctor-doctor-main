import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/policies/policies_ctrl.dart';

class PoliciesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PoliciesCtrl());
  }
}
