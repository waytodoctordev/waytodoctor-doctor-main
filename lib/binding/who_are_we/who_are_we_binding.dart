import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/who_are_we/who_are_we_ctrl.dart';

class WhoAreWeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WhoAreWeCtrl());
  }
}
