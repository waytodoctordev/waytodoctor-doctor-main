import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/specialization_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/specialization_binding.dart';
import 'package:way_to_doctor_doctor/controller/form/form_ctrl.dart';
import 'package:way_to_doctor_doctor/model/create_certificate/create_certificate_mode.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SpecializationCtrl extends GetxController {
  static SpecializationCtrl get find => Get.find();

  late File image;

  // bool isImageAdded = false;

  late File specializationCertificate;
  File professionalLicense = File('');

  RxBool isAttachmentAdded = false.obs;

  // bool isSpecializationCertificateAdded = false;
  getFile(context) async {
    FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.image,
        allowMultiple: false);
    if (result != null) {
      print('result != null');
      File file = File(result.files.single.path.toString());
      if (MySharedPreferences.isDoctor) {

        specializationCertificate = file;
        isAttachmentAdded.value= true;
        print('specializationCertificate $specializationCertificate');


      } else {
        print('result == null');
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
    print('checkSpecialization specializationCertificate$specializationCertificate');
    AppConstants.showLoading(context);
    createCertificateModel = await SpecializationApi.uploadPractice(
      image: MySharedPreferences.isDoctor
          ? specializationCertificate
          : professionalLicense,
    );
    if (createCertificateModel == null) {
      print('createCertificateModel == null ${createCertificateModel!.code }');

      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createCertificateModel!.code == 200) {
      print('createCertificateModel!.code ${createCertificateModel!.code }');
      MySharedPreferences.lastScreen = 'SpecializationEndScreen';
      Get.offAll(() => const SpecializationEndScreen(),
          binding: SpecializationBinding());
      FormCtrl.find.updateUserData(
          dataBody: {'step': '3'}, context: context).whenComplete(() {
        MySharedPreferences.formCurrentIndex = 0;
        MySharedPreferences.formIndicatorCurrentIndex = 0;
      }); // payment passed step 1

      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    }
    else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

  // EditCenterInfoModel? profLicense;

  // Future professionalLicenseRequest({
  //   required BuildContext context,
  //   required String name,
  //   required String phone,
  //    File? imageProfile,
  //   required String address,
  //    File? professionalLicense,
  //   bool isEditCenterInfo = false
  // }) async {
  //
  //   profLicense = await EditCenterInfoApi.data(
  //       name:name,
  //       address: address,
  //       phone: phone,
  //       // professionalLicense: professionalLicense,
  //       imageProfile: imageProfile,
  //       isEditCenterInfo:true
  //   );
  //   if (profLicense == null) {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //     // Loader.hide();
  //     return;
  //   }
  //   if (profLicense!.code == 200) {
  //     print('profLicense!.code == 200');
  //    MySharedPreferences.fName = profLicense!.data!.name!;
  //    MySharedPreferences.address = profLicense!.data!.address!;
  //    MySharedPreferences.userNumber = profLicense!.data!.phoneNumber!;
  //    MySharedPreferences.userImage = '${ApiUrl.mainUrl}/${profLicense!.data!.image!}';
  //    Loader.hide();
  //    update();
  //    print('      isEditCenterInfo $isEditCenterInfo');
  //     isEditCenterInfo
  //         ?  Get.offAll(() =>  CenterHomeScreen(),)
  //         :   update() ;
  //     //
  //     AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
  //
  //     return profLicense;
  //   } else {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //   }
  //   Loader.hide();
  // }

}