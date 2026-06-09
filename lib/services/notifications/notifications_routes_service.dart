import 'dart:developer';

import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_appointments_details/clinic_appointments_details.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/clinic_appointment_detail_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/doctor_appointments_details_screen.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../binding/for_doctor/appointments_details/appointments_details_binding.dart';
import '../../controller/chat_ctrl.dart';
import '../../ui/screens/messanger/chat_screen.dart';

class RoutesService {
  void toggle(Map<String, dynamic> notificationsMap) {
    try {
      if (MySharedPreferences.isDoctor) {
        if (notificationsMap['screen'] == 'DOCTOR_APPOINTMENT_DETAILS_SCREEN') {
          // Get.put(DoctorAppointmentsDetailsCtrl());
          Get.to(
            DoctorAppointmentDetailsScreen(
                appointmentId: notificationsMap['appointment_id'],
                bookingType: notificationsMap['booking_type']),
            binding: AppointmentsDetailsBinding(),
          );
        }
        if (notificationsMap['status'] == 'CHAT') {
          Get.put(() => ChatCtrl());
          Get.to(() => ChatScreen(
                patientId: int.parse(notificationsMap['patientId']),
                patientName: notificationsMap['patientName'],
                bookingType: notificationsMap['bookingType'],
                appointmentId: int.parse(notificationsMap['appointmentId']),
                status: notificationsMap['appointmentStatus'],
              ));
        }
      } else {
        if (notificationsMap['screen'] == 'CLINIC_APPOINTMENT_DETAILS_SCREEN') {
          Get.to(
              ClinicAppointmentDetailsScreen(
                id: notificationsMap['appointment_id'],
              ),
              binding: ClinicAppointmentsDetailsBinding());
        }
      }

      // switch (data.type) {
      //   // case 'DOCTOR_APPOINTMENT_DETAILS_SCREEN':
      //   //   Get.to(
      //   //     () => DoctorAppointmentDetailsScreen(
      //   //       appointmentId: data.routeId.toString(),
      //   //     ),
      //   //     binding: AppointmentsDetailsBinding(),
      //   //   );
      //   //   break;
      //   case 'CLINIC_APPOINTMENT_DETAILS_SCREEN':
      //     Get.to(
      //       () => ClinicAppointmentDetailsScreen(
      //         id: data.routeId.toString(),
      //       ),
      //       binding: AppointmentsDetailsBinding(),
      //     );
      //     break;
      //   default:
      //     {
      //       break;
      //     }
      // }
    } catch (e) {
      log("RouteError:: $e");
    }
  }
}
