import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FormCtrl());
  }
}
