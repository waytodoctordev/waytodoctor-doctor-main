import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/advantages/advantages_ctrl.dart';

class AdvantagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdvantageCtrl());
  }
}
