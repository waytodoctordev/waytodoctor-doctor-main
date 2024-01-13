// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/specialization_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/specialization_binding.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/model/center/edit_center_info_model.dart';
import 'package:way_to_doctor_doctor/model/create_certificate/create_certificate_mode.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../api/for_center/edit_center_info.dart';
import '../../binding/registration/check_participate_binding.dart';
import '../../model/center/category_centers.dart';
import '../../ui/screens/registration/check_practice/widgets/check_practice_end.dart';

class SpecializationCtrl extends GetxController {
  static SpecializationCtrl get find => Get.find();

  late File image;

  // bool isImageAdded = false;

  late File specializationCertificate;
  File professionalLicense = File('');

  RxBool isAttachmentAdded = false.obs;

  // bool isSpecializationCertificateAdded = false;
  getFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false); //!MySharedPreferences.isProfileImage
    if (result != null) {
      File file = File(result.files.single.path.toString());
      if (MySharedPreferences.isDoctor) {
        // MySharedPreferences.isProfileImage
        //     ? image = file
        //     :
        specializationCertificate = file;
        isAttachmentAdded.value= true;

        // isImageAdded = true;
      } else {
        // MySharedPreferences.isProfileImage
        //     ? image = file
        //     :
        professionalLicense = file;
        isAttachmentAdded.value = true;
      }
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  CreateCertificateModel? createCertificateModel;

  Future checkSpecialization({
    required BuildContext context,
  }) async {
    AppConstants.showLoading(context);
    createCertificateModel = await SpecializationApi.uploadPractice(
      image: MySharedPreferences.isDoctor
          ? specializationCertificate
          : professionalLicense,
    );
    if (createCertificateModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createCertificateModel!.code == 200) {
      MySharedPreferences.lastScreen = 'SpecializationEndScreen';
      Get.offAll(() => const SpecializationEndScreen(),
          binding: SpecializationBinding());
      FormCtrl.find.updateUserData(
          dataBody: {'step': '3'}, context: context).whenComplete(() {
        MySharedPreferences.formCurrentIndex = 0;
        MySharedPreferences.formIndicatorCurrentIndex = 0;
      }); // payment passed step 1

      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

  EditCenterInfoModel? profLicense;

  Future professionalLicenseRequest({
    required BuildContext context,
    required String name,
    required String phone,
    required File imageProfile,
    required String address,
    required File professionalLicense,

  }) async {
    AppConstants.showLoading(context);
    profLicense = await EditCenterInfoApi.data(
        imageProfile: imageProfile,
        name:name,
        address: address,
        phone: phone,
        professionalLicense: professionalLicense
    );
    if (profLicense == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (profLicense!.code == 200) {
     MySharedPreferences.fName = profLicense!.data!.name!;
     MySharedPreferences.address = profLicense!.data!.address!;
     MySharedPreferences.userNumber = profLicense!.data!.phoneNumber!;
     MySharedPreferences.userImage = profLicense!.data!.image!;
     MySharedPreferences.userNumber = profLicense!.data!.phoneNumber!;

      Get.offAll(() =>  CenterHomeScreen(),);
      // FormCtrl.find.updateUserData(
      //     dataBody: {'step': '3'}, context: context).whenComplete(() {
      //   MySharedPreferences.formCurrentIndex = 0;
      //   MySharedPreferences.formIndicatorCurrentIndex = 0;
      // }); // payment passed step 1

      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

}