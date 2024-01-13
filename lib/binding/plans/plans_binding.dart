import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';

class PlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlansCtrl());
  }
}
