import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments/doctor_appointments_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/plans/plans_ctrl.dart';

class DoctorBaseNavBarBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(DoctorBaseNavBarCtrl(), permanent: true);
    Get.put(PlansCtrl(), permanent: true);
    Get.put(DoctorHomeScreenCtrl(), permanent: true);
    Get.put(DoctorAppointmentsCtrl(), permanent: true);
  }
}
