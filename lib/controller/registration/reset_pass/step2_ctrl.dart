// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/registration/reset_pass/reset_pass_binding.dart';
import 'package:way_to_doctor_doctor/model/registration/reset_password/reset_pass_step2_model.dart';
import 'package:way_to_doctor_doctor/services/api_request_handlers/api_service.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/forget_password/reset_password_screens/screen3.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

import '../../../model/registration/resend_otp_model.dart';
import '../../../utils/api_url.dart';
import '../../../utils/shared_prefrences.dart';
import '../otp_timer_ctrl.dart';

class ResetPassStep2Controller extends GetxController {
  // static CheckOtpModel? checkOtpModel;
  static ResetPassStep2Controller get find => Get.find();

  static ResetPassStep2Model? resetPassStep2Model;
  ApiService apiRequestService =ApiService();
  /// DONE . => CONFIRM OTP BUTTON  API REPLACED WITH OLD ResetPassStep2Api API
   Future fetchResetPassStep2Data({
    required BuildContext context,
    required String phone,
    required String code,
  }) async {

    OverLayLoader.showLoading(context);
    try{
      print('fetchResetPassStep2Data');
      print(phone);
      print('bodyt ${MySharedPreferences.email}');
      resetPassStep2Model = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.resetPassStep2}',
      fromJson: (json)=>ResetPassStep2Model.fromJson(json),
      body: {
        "phone": phone,
        "code": code,
        "type": MySharedPreferences.skipOtp,
        'email':MySharedPreferences.email
      },

      context: context);

      print('resetPassStep2Model!.code == 200 ${resetPassStep2Model!.code == 200}');
      if (resetPassStep2Model!.code == 200) {
        Get.to(() => ResetPasswordScreen(phone: phone),
            binding: ResetPassBinding());
        Loader.hide();
      }
    }catch(error){
      print('eoor');
      print('${ resetPassStep2Model!.msg}');
      resetPassStep2Model!.msg ==''
          ? AppConstants().showMsgToast(context, msg:  AppConstants.failedMessage)
          : AppConstants().showMsgToast(context, msg: resetPassStep2Model!.msg!);
      Loader.hide();
      return;
    }
    Loader.hide();
  }

  ResendOtpModel? resendOtpModel;
/// DONE RESEND OTP BUTTON REPLACED WITH OLD ReSendOtpApi API
  Future resendOtp({
    required BuildContext context,
    required String phone,
  }) async {
    print('resendOtp');
    OverLayLoader.showLoading(context);
    try {
      resendOtpModel = await apiRequestService.makeRequest(
        method: AppConstants.postMethod,
        url: '${ApiUrl.mainUrl}${ApiUrl.updateUserNumber}',
        fromJson: (json) => ResendOtpModel.fromJson(json),
        body: {
          "phone": phone,
        },);
      if (resendOtpModel!.code == 200) {
        print('resendOtpModel == 200');
        OTPTimerCtrl.find.counter.value = 60;
        MySharedPreferences.userNumber = phone;
        AppConstants().showMsgToast(context, msg: resendOtpModel!.msg!);
        Loader.hide();
      } else {
        resendOtpModel!.msg == ''
            ? AppConstants().showMsgToast(
            context, msg: AppConstants.failedMessage)
            : AppConstants().showMsgToast(context, msg: resendOtpModel!.msg!);

        Loader.hide();
      }
    } catch (error) {
      AppConstants().showMsgToast(
          context, msg: AppConstants.failedMessage);
      Loader.hide();
    }

    // resendOtpModel = await ReSendOtpApi.data(userId: userId);
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
