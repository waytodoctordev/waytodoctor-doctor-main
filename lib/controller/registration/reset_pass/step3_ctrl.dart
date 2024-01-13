// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/reset_password/step3_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/model/registration/reset_password/reset_pass_step3_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

import '../../../utils/shared_prefrences.dart';

class ResetPassStep3Controller extends GetxController {
  final isPasswordObscure = true.obs;
  final isConfirmPasswordObscure = true.obs;
  static ResetPassStep3Model? resetPassStep3Model;
  late TextEditingController newPasswordCtrl;
  late TextEditingController confirmPasswordCtrl;

  @override
  void onInit() {
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  void changePasswordObscure() {
    isPasswordObscure.value = !isPasswordObscure.value;
    update();
  }

  void changeConfirmPasswordObscure() {
    isConfirmPasswordObscure.value = !isConfirmPasswordObscure.value;
    update();
  }

  static Future fetchResetPassStep3Data({
    required BuildContext context,
    required String phone,
    required String password,
  }) async {
    OverLayLoader.showLoading(context);
    resetPassStep3Model =
        await ResetPassStep3Api.data(phone: phone, password: password);
    if (resetPassStep3Model == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);

      Loader.hide();
      return;
    }
    if (resetPassStep3Model!.code == 200) {
      AppConstants()
          .showMsgToast(context, msg: "password changed successfully");
      Get.offAll(() => const RegistrationScreen(),
          binding: RegestirationBinding());
    } else if (resetPassStep3Model!.code == 500) {
      fetchResetPassStep3Data(
          context:context,
          phone:MySharedPreferences.countryCode+phone,
          password: password);
    } else {
      AppConstants().showMsgToast(context, msg: resetPassStep3Model!.msg!);
    }
    Loader.hide();
  }
}
