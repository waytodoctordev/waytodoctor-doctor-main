// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/reset_password/step2_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/reset_pass/reset_pass_binding.dart';
import 'package:way_to_doctor_doctor/model/registration/reset_password/reset_pass_step2_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/forget_password/reset_password_screens/screen3.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

import '../../../utils/shared_prefrences.dart';

class ResetPassStep2Controller extends GetxController {
  // static CheckOtpModel? checkOtpModel;
  static ResetPassStep2Model? resetPassStep2Model;

  static Future fetchResetPassStep2Data({
    required BuildContext context,
    required String phone,
    required String code,
  }) async {
    OverLayLoader.showLoading(context);
    resetPassStep2Model =
        await ResetPassStep2Api.data(phone: phone, code: code);
    if (resetPassStep2Model == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);

      Loader.hide();
      return;
    }
    if (resetPassStep2Model!.code == 200) {
      Get.to(() => ResetPasswordScreen(phone: phone),
          binding: ResetPassBinding());
    } else if (resetPassStep2Model!.code == 500) {
      AppConstants().showMsgToast(context, msg: 'incorrect otp');

      // Fluttertoast.showToast(msg: TranslationService.getString('incorrect_otp_key'));
    } else {
      AppConstants().showMsgToast(context, msg: resetPassStep2Model!.msg!);
    }
    Loader.hide();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithPhoneNumber(
    String verificationCode,
    BuildContext context,
    String verificationId,
    String phone,
  ) async {
    // log(MySharedPreferences.countryCode + phone);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: verificationCode,
    );
    try {
      OverLayLoader.showLoading(context);

      await _auth.signInWithCredential(credential)
          // .catchError((err) {
          //   AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
          // })
          .then((value) {
        log(MySharedPreferences.userNumber);
        Get.to(() => ResetPasswordScreen(phone: phone),
            binding: ResetPassBinding());
        Loader.hide();
      });
    } catch (e) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      log(e.toString());
      // return Future.error(e);
      Loader.hide();
    }
    // do something with the authenticated user
  }
}
