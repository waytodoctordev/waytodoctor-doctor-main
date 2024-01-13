import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/description_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/details_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/doctor_description_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/doctor_files_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/patient_files_component.dart';

class AppointmentDetails extends StatelessWidget {
  final AppointmentData appointmentData;
  const AppointmentDetails({super.key, required this.appointmentData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 37, right: 37, bottom: 10),
      children: [
        DetailsComponent(
          caseType: appointmentData.type.toString(),
          communication: appointmentData.bookingType.toString(),
          place: appointmentData.location.toString(),
          paymentAccount: appointmentData.paymentAccount.toString(),
          date: appointmentData.date.toString().split(' ')[0],
          time:
              "${appointmentData.time.toString().split(':')[0]}:${appointmentData.time.toString().split(':')[1]}",
          avilaiblity: appointmentData.status.toString().tr,
          paymentMethod: appointmentData.paymentMethod.toString(),
        ),
        const SizedBox(height: 20),
        PatientDescriptionComponent(
            description: appointmentData.caseDescription.toString()),
        const SizedBox(height: 20),
        PatientFilesComponents(attachedFiles: appointmentData.files!),
        const SizedBox(height: 20),
        DoctorDescriptionComponent(
            doctorReplay: appointmentData.replays!,
            appointmentID: appointmentData.id.toString()),
        const SizedBox(height: 20),
        DoctorFilesComponents(
            doctorDescription: appointmentData.doctorDescription!,
            appointmentID: appointmentData.id.toString()),
      ],
    );
  }
}
