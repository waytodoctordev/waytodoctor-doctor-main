// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments_details/create_description_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments_details/get_description_by_appointment.dart';
import 'package:way_to_doctor_doctor/model/create_replays_model/create_replays_model.dart';
import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

class DoctorDescriptionCtrl extends GetxController {
  static DoctorDescriptionCtrl get find => Get.find();

  File? pickedFile;

  getFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      pickedFile = file;
      // print(pickedFiles);
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  ReplaysModel? replaysModel;
  late Future<ReplaysModel?> initializeDescriptionFuture;
  Future<ReplaysModel?> fetchDescriptionById(String appointmentId) async {
    replaysModel = await DoctorDescriptionsApi.data(appointmentId: appointmentId);
    return replaysModel;
  }

  initFetchDescriptions(String appointmentId) {
    initializeDescriptionFuture = fetchDescriptionById(appointmentId);
  }

  CreateReplaysModel? createReplaysModel;
  Future createDescription({
    required BuildContext context,
    required File file,
    required String content,
    required String date,
    required String appointmentId,
  }) async {
    AppConstants.showLoading(context);
    createReplaysModel = await CreateDescriptionApi.uploadDescription(file: file, content: content, date: date, appointmentId: appointmentId);
    if (createReplaysModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createReplaysModel!.code == 200) {
      initFetchDescriptions(appointmentId);
      update();
      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }
}
