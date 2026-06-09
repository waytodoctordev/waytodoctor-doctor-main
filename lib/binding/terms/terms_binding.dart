import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/terms/terms_ctrl.dart';

class Termsinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsCtrl());
  }
}
