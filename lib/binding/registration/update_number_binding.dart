import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/update_number_ctrl.dart';

class UpdateNumberBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateNumberCtrl());
  }
}
