// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/delete_account/delete_account_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_password_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_personal_into_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/model/delete_model.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../api/logout/logout_api.dart';

class EditAccountCtrl extends GetxController {
  static EditAccountCtrl get find => Get.find();
  PageController pageCtrl = PageController(initialPage: 0);
  bool isPersonalInformation = true;
  int currentPage = 0;

  void getCurrentPage(int index) {
    currentPage = index;
    update();
  }

  void setIsPersonalBool(bool value) {
    isPersonalInformation = value;
    update();
  }

   TextEditingController nameCtrl= TextEditingController();
   TextEditingController phoneNumberCtrl= TextEditingController();

   TextEditingController newPasswordCtrl= TextEditingController();
   TextEditingController currentPasswordCtrl= TextEditingController();
   TextEditingController confirmPasswordCtrl= TextEditingController();

  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

  void toggleCurrentPassword() {
    showCurrentPassword = !showCurrentPassword;
    update();
  }

  void toggleNewPassword() {
    showNewPassword = !showNewPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  @override
  void onInit() {
    // nameCtrl = TextEditingController(text: MySharedPreferences.fName);
    phoneNumberCtrl = TextEditingController(
        text: MySharedPreferences.userNumber
            .toString()
            .split(MySharedPreferences.countryCode)
            .join());
    newPasswordCtrl = TextEditingController();
    currentPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    // nameCtrl.dispose();
    //
    // phoneNumberCtrl.dispose();
    // newPasswordCtrl.dispose();
    //
    // currentPasswordCtrl.dispose();
    // confirmPasswordCtrl.dispose();
    super.onClose();
  }

  DoctorDetailsModel? doctorDetailsModel;

  UserModel? userModel;
  Future updatePassword({
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    userModel = await UpdatePasswordApi.data(password: password);
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      MySharedPreferences.password = password;
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      print('is doctor ? nancy look here and jeolus alaa ${MySharedPreferences.isDoctor}');

    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }

  Future updateInformation({
    required String userName,
    required String phone,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel = await UpdateInformationForDoctorApi.data(
        userName: userName, email: 'email', phone: phone);
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      // MySharedPreferences.email = doctorDetailsModel!.data!.email.toString();
      MySharedPreferences.userNumber =
          doctorDetailsModel!.data!.phone.toString();
      MySharedPreferences.fName = doctorDetailsModel!.data!.name.toString();

      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  DeleteModel? deleteModel;
  Future deleteAccount({
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    deleteModel = await DeleteAccount().deleteAccount();
    if (deleteModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (deleteModel!.code == 200) {
      Get.back();
      Logout().logout();
      MySharedPreferences.clearProfile();
      Get.deleteAll(force: true);
      Get.offAll(
        () => const RegistrationScreen(),
        binding: RegestirationBinding(),
      );
    } else if (deleteModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: deleteModel!.msg!);
    }
    Loader.hide();
  }
}
