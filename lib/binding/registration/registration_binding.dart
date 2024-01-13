import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_up_ctrl.dart';

class RegestirationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInCtrl(), permanent: true);
    Get.put(SignUpCtrl(), permanent: true);
  }
}
