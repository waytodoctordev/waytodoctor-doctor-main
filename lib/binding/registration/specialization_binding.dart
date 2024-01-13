import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/specialization_ctrl.dart';

class SpecializationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SpecializationCtrl());
  }
}
