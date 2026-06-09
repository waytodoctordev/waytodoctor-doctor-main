// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/resend_otp_api.dart';
import 'package:way_to_doctor_doctor/model/registration/resend_otp_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import 'otp_timer_ctrl.dart';

class ResendOtpCtrl {
  static ResendOtpCtrl get find => Get.find();

  ResendOtpModel? resendOtpModel;

  Future resendOtp({
    required BuildContext context,
    required int userId,
    required String phone,
  }) async {
    print('resendOtp');
    OverLayLoader.showLoading(context);
    resendOtpModel = await ReSendOtpApi.data(userId: userId);
    if (resendOtpModel == null) {
      print('resendOtpModel == null');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (resendOtpModel!.code == 200) {
      print('resendOtpModel == 200');
      OTPTimerCtrl.find.counter.value = 60;
      MySharedPreferences.userNumber = phone;
      AppConstants().showMsgToast(context, msg: resendOtpModel!.msg!);
    } else if (resendOtpModel!.code == 500) {
      print('resendOtpModel == 500');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: resendOtpModel!.msg!);
    }
    Loader.hide();
  }
}
