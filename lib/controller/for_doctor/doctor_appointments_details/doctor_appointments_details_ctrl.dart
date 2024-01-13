// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments_details/appointments_details_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments_details/update_appointment_details_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments_details/update_appointment_payment_method_api.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/view_appointment_model.dart';
import 'package:way_to_doctor_doctor/model/update_appointment_for_clinic/update_appointment_for_clinic_api.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

class DoctorAppointmentsDetailsCtrl extends GetxController {
  static DoctorAppointmentsDetailsCtrl get find => Get.find();
  int currentIndex = 0;
  late PageController pageController;

  void getCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex);
    super.onInit();
  }

  List<File> pickedFiles = [];

  getFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      pickedFiles.add(file);
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  removeFromPickedFiles(int index) {
    pickedFiles.removeAt(index);
    update();
  }

  ViewAppointmentModel? viewAppointmentModel;
  late Future<ViewAppointmentModel?> initializeAppointmentDetailsFuture;
  Future<ViewAppointmentModel?> fetchAppointmentById(
      String appointmentId) async {
    viewAppointmentModel =
        await GetAppointmentApi.data(appointmentId: appointmentId);
    return viewAppointmentModel;
  }

  initFetchAppointment(String appointmentId) {
    initializeAppointmentDetailsFuture = fetchAppointmentById(appointmentId);
    update();
  }

  UpdateAppointmentModel? appointmentsModel;
  Future updateAppointmentStatus({
    required String appointmentId,
    required String status,
    // required String pymentMethod,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    appointmentsModel = await UpdateAppointmentForDoctorApi.data(
      appointmentId: appointmentId,
      status: status,
    );
    if (appointmentsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (appointmentsModel!.code == 200) {
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (appointmentsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: appointmentsModel!.msg!);
    }
    Loader.hide();
  }

  Future updatePaymentMethod({
    required String appointmentId,
    required String paymentAccount,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    appointmentsModel = await UpdateAppointmentPaymentMethod.data(
      appointmentId: appointmentId,
      paymentAccount: paymentAccount,
    );
    print('appointmentsModel?.code)${appointmentsModel?.code}');
    if (appointmentsModel == null) {
      print('appointmentsModel!.code == null');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (appointmentsModel!.code == 200) {
      print('appointmentsModel!.code == 200');
      await updateAppointmentStatus(
          appointmentId: appointmentId,
          status: AppConstants.approved,
          context: context);
      await initFetchAppointment(appointmentId);
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (appointmentsModel!.code == 500) {
      print('appointmentsModel!.code == 500');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      print('appointmentsModel!.code == 600');
      AppConstants().showMsgToast(context, msg: appointmentsModel!.msg!);
    }
    Loader.hide();
  }
}
