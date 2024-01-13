// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointment_details/update_appointment_details_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/appointment_details/view_appointment_api.dart';
import 'package:way_to_doctor_doctor/model/update_appointment_for_clinic/update_appointment_for_clinic_api.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

import '../clinic_home_screen/clinic_home_ctrl.dart';
import '../clininc_appointments/clinic_appointments_ctrl.dart';

class ClinincAppointmentsDetailsCtrl extends GetxController {
  static ClinincAppointmentsDetailsCtrl get find => Get.find();

  List<String> caseTypes = [
    'Normal'.tr,
    'Consultation'.tr,
    'Urgent'.tr,
  ];

  List<String> caseTypesEnglish = [
    'Normal',
    'Consultation',
    'Urgent',
  ];

  List<String> communicationTypes = [
    'Clinic'.tr,
    'Video'.tr,
    'Chat'.tr,
    'Call'.tr,
  ];

  List<String> communicationTypesEnglish = [
    'Clinic',
    'Video',
    'Chat',
    'Call',
  ];
  String? currentTime;
  String? currentDate;
  String? currentCaseType;
  String? currentCaseTypeEnglish;
  String? currentCommunication;
  String? currentCommunicationEnglish;
  String? place;
  String? paymentMethod;
  late TextEditingController placeCtrl;
  late TextEditingController paymentMethodCtrl;

  setCase(String type) {
    currentCaseType = type;
    currentCaseTypeEnglish = caseTypesEnglish[caseTypes.indexOf(type)];
    update();
  }

  setCommunication(String communication) {
    currentCommunication = communication;
    currentCommunicationEnglish =
        communicationTypesEnglish[communicationTypes.indexOf(communication)];
    update();
  }

  setTime(String time) {
    currentTime = time;
    update();
  }

  setDate(String date) {
    currentDate = date;
    update();
  }

  UpdateAppointmentModel? appointmentsModel;
  Future updateAppointment(
      {required String appointmentId,
      required String status,
      required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    appointmentsModel = await UpdateAppointmentForClinicApi.data(
      appointmentId: appointmentId,
      time: currentTime.toString(),
      date: currentDate.toString(),
      status: status,
      type: currentCaseTypeEnglish.toString(),
      bokkingType: currentCommunicationEnglish.toString(),
      location: placeCtrl.text.toString(),
      pay: paymentMethodCtrl.text.toString(),
    );
    if (appointmentsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (appointmentsModel!.code == 200) {
      await ClinicHomeScreenCtrl.find.fetchUrgentAppointments();
      await ClinicHomeScreenCtrl.find.fetchAppointmentsCounter();
      ClinicHomeScreenCtrl.find.pagingController.refresh();
      ClinicAppointmentsCtrl.find.pagingController.refresh();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (appointmentsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: appointmentsModel!.msg!);
    }
    Loader.hide();
  }

  UpdateAppointmentModel? appointmentdetailssss;
  late Future<UpdateAppointmentModel?> initializeAppointmentForClinic;

  initAppointmentDetails(String appointmentId) {
    initializeAppointmentForClinic =
        fetchAppointmentDetailsForClinic(appointmentId);
  }

  Future<UpdateAppointmentModel?> fetchAppointmentDetailsForClinic(
      String id) async {
    appointmentdetailssss =
        await ViewAppointmentForClinicApi.data(appointmentId: id);
    if (appointmentdetailssss!.code == 200) {
      return appointmentdetailssss;
    }
    return null;
  }
}
