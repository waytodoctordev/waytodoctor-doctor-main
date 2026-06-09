import 'package:get/get.dart';

import '../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';

class DoctorDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorDetailsCtrl());
  }
}
