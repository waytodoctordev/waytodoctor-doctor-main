// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/create_payment/create_payment_mode.dart';
import 'package:way_to_doctor_doctor/model/create_pictures/create_pictures_mode.dart';
import 'package:way_to_doctor_doctor/model/delete_model.dart';

import '../../../api/for_doctor/doctor_details/doctor_details_api.dart';
import '../../../api/registration/check_practice_api.dart';
import '../../../api/registration/update_form_information_api.dart';
import '../../../model/create_certificate/create_certificate_mode.dart';
import '../../../model/create_studies/create_studies_mode.dart';
import '../../../model/doctor_model/doctor_model.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/user/user_model.dart';
import '../../../ui/widgets/overlay_loader.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/shared_prefrences.dart';

class DoctorDetailsCtrl extends GetxController {
  static DoctorDetailsCtrl get find => Get.find();

  DoctorDetailsModel? doctor;
  late Future<DoctorDetailsModel?> initializeDoctorDetailsFuture;

  Future<DoctorDetailsModel?> fetchDoctorDetailsData() async {
    doctor = await DoctorDetailsApi.data(doctorId: MySharedPreferences.id);
    update();
    return doctor;
  }

  init() {
    initializeDoctorDetailsFuture = fetchDoctorDetailsData();
    update();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  final ImagePicker _picker = ImagePicker();

  Future getProfileImage({
    required BuildContext context,
  }) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      updateUserImage(profileImage: imageFile, context: context);
      // updateProfileImage(profileImage: imageFile, context: context);
      update();
    } else {
      debugPrint('no image selected');
    }
  }

  UserModel? userModel;

  Future updateUserImage(
      {required File profileImage, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    userModel = await UpdateUserDataApi.updateUserImage(
      profileImage: profileImage,
    );
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      await updateDoctorImage(profileImage: profileImage, context: context);
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }

  DoctorDetailsModel? doctorDetailsModel;

  Future updateDoctorImage(
      {required File profileImage, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel = await UpdateUserDataApi.updateDoctorImage(
      profileImage: profileImage,
    );
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      MySharedPreferences.userImage =
          doctorDetailsModel!.data!.image.toString();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      init();
      // update();
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  Future updateDoctorExperince(
      {required int experience, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel =
        await DoctorDetailsApi().doctorExperience(experience: experience);
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      MySharedPreferences.experience = doctorDetailsModel!.data!.experience!;
      // payment passed step 1

      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      init();
      // update();
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  Future updateDoctorDescription(
      {required String description, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel =
        await DoctorDetailsApi().doctorDescription(description: description);
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      MySharedPreferences.description = doctorDetailsModel!.data!.description!;
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      init();
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  getCertificate(context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      checkPractice(context: context, image: file);
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  CreateCertificateModel? createCertificateModel;

  Future checkPractice({
    required BuildContext context,
    required File image,
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
      init();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

  getStudies(context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      createStudies(context: context, image: file);
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  CreateStudiesModel? createStudiesModel;
  Future createStudies({
    required BuildContext context,
    required File image,
  }) async {
    AppConstants.showLoading(context);
    createStudiesModel = await DoctorDetailsApi.createStudies(image: image);
    if (createStudiesModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createStudiesModel!.code == 200) {
      init();
      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

  DeleteModel? deleteModel;
  Future deleteCertificate({
    required BuildContext context,
    required String id,
  }) async {
    AppConstants.showLoading(context);
    deleteModel = await DoctorDetailsApi.deleteCertificate(id: id);
    if (deleteModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (deleteModel!.code == 200) {
      init();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.deletedSuccessfully);
      Loader.hide();
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
  }

  Future deleteStudies({
    required BuildContext context,
    required String id,
  }) async {
    AppConstants.showLoading(context);
    deleteModel = await DoctorDetailsApi.deleteStudies(id: id);
    if (deleteModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (deleteModel!.code == 200) {
      init();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.deletedSuccessfully);
      Loader.hide();
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
  }

  getPictures(context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path.toString());
      createPictures(context: context, image: file);
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  CreatePicturesModel? createPicturesModel;
  Future createPictures({
    required BuildContext context,
    required File image,
  }) async {
    AppConstants.showLoading(context);
    createPicturesModel = await DoctorDetailsApi.createPictures(image: image);
    if (createPicturesModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createPicturesModel!.code == 200) {
      init();
      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

  Future deletePictures({
    required BuildContext context,
    required String id,
  }) async {
    AppConstants.showLoading(context);
    deleteModel = await DoctorDetailsApi.deletePictures(id: id);
    if (deleteModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (deleteModel!.code == 200) {
      init();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.deletedSuccessfully);
      Loader.hide();
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
  }

  CreatePaymentModel? createPaymentModel;
  Future createPayment({
    required BuildContext context,
    required String name,
  }) async {
    AppConstants.showLoading(context);
    createPaymentModel = await DoctorDetailsApi.createPayment(name: name);
    if (createPaymentModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (createPaymentModel!.code == 200) {
      init();
      AppConstants().showMsgToast(context, msg: AppConstants.addedSuccessfully);
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }

  Future deletePayment({
    required BuildContext context,
    required String id,
  }) async {
    AppConstants.showLoading(context);
    deleteModel = await DoctorDetailsApi.deletePyment(id: id);
    if (deleteModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (deleteModel!.code == 200) {
      init();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.deletedSuccessfully);
      Loader.hide();
    } else {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
  }
}
