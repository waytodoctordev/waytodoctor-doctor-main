import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/description_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/doctor_description_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/doctor_files_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/patient_files_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/user_medical_history/files_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/user_medical_history/replays_component.dart';


class UserMedicalHistoryDetails extends StatelessWidget {
  final AppointmentData historyData;
  const UserMedicalHistoryDetails({super.key, required this.historyData});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(left: 37, right: 37, bottom: 10),
      children: [
        MedicalHistoryFilesComponents(attachedFiles: historyData.userMedicalHistory!.files),
        const SizedBox(height: 20),
        MedicalHistoryContentsComponents(
            description: historyData.userMedicalHistory!.doctorDescription!,
        title: 'Doctor Description'.tr,
        ),
        const SizedBox(height: 20),
        MedicalHistoryContentsComponents(
          description:  historyData.userMedicalHistory!.replays,
          title: 'Doctor Replays'.tr,
        ),
        const SizedBox(height: 20),
        MedicalHistoryContentsComponents(
            description: historyData.userMedicalHistory!.userReplays!,
          title: 'User Replays'.tr,
        ),
      ],
    );
  }
}
