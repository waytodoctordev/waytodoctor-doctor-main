// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/doctor_sign_up_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/update_number_binding.dart';
import 'package:way_to_doctor_doctor/model/clinic_login/clinic_login_model.dart';
import 'package:way_to_doctor_doctor/model/doctor_signup/doctor_signup_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/phone_sign_up/phone_sign_up_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SignUpCtrl extends GetxController {
  static SignUpCtrl get find => Get.find();

  DoctorSignUpModel? doctorSignUpModel;

  Future fetchDoctorSignUpData({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    doctorSignUpModel = await DoctorSignUpApi()
        .data(password: password, email: email, name: name);
    if (doctorSignUpModel == null) {
      AppConstants()
          .showMsgToast(context, msg: 'Email has been already regirsted'.tr);
      // AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorSignUpModel!.code == 200) {
      MySharedPreferences.accessToken = doctorSignUpModel!.data!.token!;
      MySharedPreferences.id = doctorSignUpModel!.data!.userDoctor!.id!;
      MySharedPreferences.userId = doctorSignUpModel!.data!.userDoctor!.userId!;
      MySharedPreferences.fName = doctorSignUpModel!.data!.userDoctor!.name!;
      MySharedPreferences.email = doctorSignUpModel!.data!.userDoctor!.email!;
      MySharedPreferences.step = doctorSignUpModel!.data!.userDoctor!.step!;
      MySharedPreferences.clinicUserID =
          doctorSignUpModel!.data!.userDoctor!.clinicUserId.toString();

      // MySharedPreferences.userNumber = doctorSignUpModel!.data!.userDoctor!.phone!;
      // MySharedPreferences.countryCode = '${MySharedPreferences.userNumber[0]}${MySharedPreferences.userNumber[1]}${MySharedPreferences.userNumber[2]}${MySharedPreferences.userNumber[3]}';
      MySharedPreferences.userImage =
          doctorSignUpModel!.data!.userDoctor!.image!;
      MySharedPreferences.address =
          doctorSignUpModel!.data!.userDoctor!.address!;
      MySharedPreferences.categoryId =
          doctorSignUpModel!.data!.userDoctor!.categoryId!;
      MySharedPreferences.categoryName =
          doctorSignUpModel!.data!.userDoctor!.categoryName!;
      MySharedPreferences.userCount =
          doctorSignUpModel!.data!.userDoctor!.userCount!;
      MySharedPreferences.rating = doctorSignUpModel!.data!.userDoctor!.rating!;
      MySharedPreferences.experience =
          doctorSignUpModel!.data!.userDoctor!.experience!;
      MySharedPreferences.description =
          doctorSignUpModel!.data!.userDoctor!.description!;
      MySharedPreferences.lat = doctorSignUpModel!.data!.userDoctor!.lat!;
      MySharedPreferences.long = doctorSignUpModel!.data!.userDoctor!.long!;
      MySharedPreferences.doctorClinicId =
          doctorSignUpModel!.data!.userDoctor!.categoryId!;
      MySharedPreferences.password = password;
      MySharedPreferences.isDoctor = true;
      MySharedPreferences.lastScreen = 'PhoneSignUpScreen';
      Get.to(() => const PhoneSignUpScreen(), binding: UpdateNumberBinding());
      AppConstants().showMsgToast(context, msg: 'Welcome '.tr + name);
    } else if (doctorSignUpModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: doctorSignUpModel!.msg!);
    } else {
      AppConstants().showMsgToast(context, msg: doctorSignUpModel!.msg!);
    }
    Loader.hide();
  }

  ClinicLoginModel? clinicLoginModel;
  // Future fetchClinicSignUpData({
  //   required String email,
  //   required String password,
  //   required String name,
  //   required BuildContext context,
  // }) async {
  //   OverLayLoader.showLoading(context);
  //   clinicLoginModel = await ClinicSignUpApi().data(password: password, email: email, name: name);
  //   if (clinicLoginModel == null) {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //     Loader.hide();
  //     return;
  //   }
  //   if (clinicLoginModel!.code == 200) {
  //     MySharedPreferences.accessToken = clinicLoginModel!.data!.token!;
  //     MySharedPreferences.id = clinicLoginModel!.data!.clinic!.id!;
  //     MySharedPreferences.userId = clinicLoginModel!.data!.clinic!.userId!;
  //     MySharedPreferences.fName = clinicLoginModel!.data!.clinic!.name!;
  //     MySharedPreferences.email = clinicLoginModel!.data!.clinic!.email!;
  //     // MySharedPreferences.step = clinicLoginModel!.data!.clinic!.step!;
  //     // MySharedPreferences.userNumber = clinicLoginModel!.data!.clinic!.phone!;
  //     // MySharedPreferences.countryCode = '${MySharedPreferences.userNumber[0]}${MySharedPreferences.userNumber[1]}${MySharedPreferences.userNumber[2]}${MySharedPreferences.userNumber[3]}';
  //     // MySharedPreferences.userImage = clinicLoginModel!.data!.clinic!.image!;
  //     MySharedPreferences.address = clinicLoginModel!.data!.clinic!.address!;
  //     // MySharedPreferences.categoryId = clinicLoginModel!.data!.clinic!.categoryId!;
  //     // MySharedPreferences.categoryName = clinicLoginModel!.data!.clinic!.categoryName!;
  //     // MySharedPreferences.userCount = clinicLoginModel!.data!.clinic!.userCount!;
  //     // MySharedPreferences.rating = clinicLoginModel!.data!.clinic!.rating!;
  //     // MySharedPreferences.experience = clinicLoginModel!.data!.clinic!.experience!;
  //     // MySharedPreferences.description = clinicLoginModel!.data!.clinic!.description!;
  //     MySharedPreferences.lat = clinicLoginModel!.data!.clinic!.lat!;
  //     MySharedPreferences.long = clinicLoginModel!.data!.clinic!.long!;
  //     // MySharedPreferences.doctorClinicId = clinicLoginModel!.data!.clinic!.categoryId!;
  //     MySharedPreferences.password = password;
  //     MySharedPreferences.lastScreen = 'PhoneSignUpScreen';
  //     Get.offAll(() => const PhoneSignUpScreen(), binding: UpdateNumberBinding());
  //     AppConstants().showMsgToast(context, msg: 'Welcome '.tr + name);
  //   } else if (clinicLoginModel!.code == 500) {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //   } else {
  //     AppConstants().showMsgToast(context, msg: clinicLoginModel!.msg!);
  //   }
  //   Loader.hide();
  // }
}
