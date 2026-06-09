import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_appointments_details_ctrl.dart';

class AppointmentsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DoctorAppointmentsDetailsCtrl());
  }
}
