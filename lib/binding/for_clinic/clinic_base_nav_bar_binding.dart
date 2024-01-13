import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_home_screen/clinic_home_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clininc_appointments/clinic_appointments_ctrl.dart';

class ClinicBaseNavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ClinicBaseNavBarCtrl(), permanent: true);
    Get.put(ClinicHomeScreenCtrl(), permanent: true);
    Get.put(ClinicAppointmentsCtrl(), permanent: true);
  }
}
