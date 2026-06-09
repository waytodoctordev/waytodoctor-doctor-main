
import 'package:get/get.dart';

import '../../controller/for_doctor/doctor_appointments/doctor_appointments_ctrl.dart';
import '../../controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import '../../controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import '../../controller/map.dart';
import '../../controller/plans/plans_ctrl.dart';
import '../../controller/registration/sign_in_ctrl.dart' show SignInCtrl;
import '../../controller/user_location_ctrl.dart';

class DoctorBaseNavBarBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(DoctorBaseNavBarCtrl(), permanent: true);
    Get.put(PlansCtrl(), permanent: true);
    Get.put(DoctorHomeScreenCtrl(), permanent: true);
    Get.put(DoctorAppointmentsCtrl(), permanent: true);
     Get.put(UserLocationCtrl(), permanent: true);
    Get.put(MapController(), permanent: true);
    Get.put(SignInCtrl(), permanent: true);

  }
}
