import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInCtrl(), permanent: true);

  }
}
