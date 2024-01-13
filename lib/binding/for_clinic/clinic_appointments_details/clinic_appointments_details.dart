import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_appointments_details/clinic_appointments_details_ctrl.dart';

class ClinicAppointmentsDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ClinincAppointmentsDetailsCtrl());
  }
}
