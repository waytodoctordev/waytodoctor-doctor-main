// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/check_practice_api.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/model/create_certificate/create_certificate_mode.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/check_practice/widgets/check_practice_end.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CheckPracticeCtrl extends GetxController {
  static CheckPracticeCtrl get find => Get.find();

  late File image;
  bool isImageAdded = false;

  getFile(context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      image = file;
      isImageAdded = true;
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  CreateCertificateModel? createCertificateModel;

  Future checkPractice({
    required BuildContext context,
  }) async {
    AppConstants.showLoading(context);
    createCertificateModel = await CreatePracticeApi.uploadPractice(
      image: image,
    );
    if (createCertificateModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createCertificateModel!.code == 200) {
      MySharedPreferences.lastScreen = 'CheckPracticeEndScreen';
      Get.offAll(() => const CheckPracticeEndScreen());
      FormCtrl.find.updateUserData(
          dataBody: {'step': '2'}, context: context).whenComplete(() {
        MySharedPreferences.formCurrentIndex = 0;
        MySharedPreferences.formIndicatorCurrentIndex = 0;
      }); // payment passed step 1

      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }
}
