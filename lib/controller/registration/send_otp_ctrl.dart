// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/send_otp_api.dart';
import 'package:way_to_doctor_doctor/api/registration/update_number_api.dart';
import 'package:way_to_doctor_doctor/binding/plans/plans_binding.dart';
import 'package:way_to_doctor_doctor/controller/registration/update_number_ctrl.dart';
import 'package:way_to_doctor_doctor/model/registration/otp_model.dart';
import 'package:way_to_doctor_doctor/model/registration/update_number_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/plans_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/registration_end.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../../ui/screens/registration/plans/widgets/subscription_end.dart';

class SendOtpCtrl {
  static SendOtpCtrl get find => Get.find();

  OtpModel? checkOtpModel;

  Future fetchOtpData({
    required BuildContext context,
    required String phone,
    required String code,
  }) async {
    OverLayLoader.showLoading(context);
    checkOtpModel = await SendOtpApi.data(phone: phone, code: code);
    if (checkOtpModel == null) {
      print('checkOtpModel!.code == null');
      print('${checkOtpModel!.msg}!');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (checkOtpModel!.code == 200) {
      print('checkOtpModel!.code == 200');
      print('${checkOtpModel!.msg}!');
      MySharedPreferences.userNumber = phone;
      if (MySharedPreferences.isDoctor) {
        print('is doctor');
        if (MySharedPreferences.subscriptionId.isNotEmpty ) {
          Get.to(() => const DoctorBaseNavBar(),
              binding: DoctorBaseNavBarBinding());
        }
        else{
          Get.to(() => const RegistrationEnd(),
          );
        }
      }
    }
    else if (checkOtpModel!.code == 500) {
      print('checkOtpModel!.code == 500');
      print('${checkOtpModel!.msg}!');
      AppConstants().showMsgToast(context, msg: checkOtpModel!.msg!);
      Loader.hide();
    }
      else {
      AppConstants().showMsgToast(context, msg: checkOtpModel!.msg!);
      Loader.hide();
    }
    Loader.hide();
  }

  UpdateNumberModel? updateNumberModel;

  Future updateDoctorNumber(
      {required String phone,
      required String userID,
      required BuildContext context}) async {
    print('updateDoctorNumber');
    OverLayLoader.showLoading(context);
    updateNumberModel =
        await UpdateNumberApi().doctorPhone(phone: phone, userID: userID);
    if (updateNumberModel == null) {
      print('updateNumberModel!.code == null');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (updateNumberModel!.code == 200) {
      print('updateNumberModel!.code == 200');
      await UpdateNumberApi()
          .data(phone: phone, userID: MySharedPreferences.userId.toString());
      // MySharedPreferences.lastScreen = 'RegistrationEnd';
      // Get.offAll(() => const RegistrationEnd());
    } else if (updateNumberModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: checkOtpModel!.msg!);
    } else {
      AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
    }
    Loader.hide();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithPhoneNumber(String verificationCode, BuildContext context,
      String verificationId) async {
    log(UpdateNumberCtrl.find.verificationIdForSms);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: MySharedPreferences.verificationId == ''
          ? verificationId
          : MySharedPreferences.verificationId,
      smsCode: verificationCode,
    );
    try {
      OverLayLoader.showLoading(context);

      await _auth.signInWithCredential(credential)
          // .catchError((err) {
          //   AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
          // })
          .then((value) {
        if (MySharedPreferences.isDoctor) {
          updateDoctorNumber(
              phone: MySharedPreferences.userNumber,
              userID: MySharedPreferences.id.toString(),
              context: context);
        }
        log(MySharedPreferences.userNumber);
        // MySharedPreferences.lastScreen = 'RegistrationEnd';
        Get.offAll(() => const RegistrationEnd());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        AppConstants().showMsgToast(context, msg: 'code is incorrect');
      } else {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      }
      // AppConstants().showMsgToast(context, msg: e.message!);
      log(e.toString());
      // return Future.error(e);
      Loader.hide();
    }
    // do something with the authenticated user
  }
  // Future updateClinicNumber(
  //     {required String phone,
  //     required String userID,
  //     required BuildContext context}) async {
  //   OverLayLoader.showLoading(context);
  //   updateNumberModel =
  //       await UpdateNumberApi().clinicPhone(phone: phone, userID: userID);
  //   if (updateNumberModel == null) {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //     Loader.hide();
  //     return;
  //   }
  //   if (updateNumberModel!.code == 200) {
  //     // MySharedPreferences.lastScreen = 'RegistrationEnd';
  //     // Get.offAll(() => const RegistrationEnd());
  //   } else if (updateNumberModel!.code == 500) {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //   } else {
  //     AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
  //   }
  //   Loader.hide();
  // }
}
