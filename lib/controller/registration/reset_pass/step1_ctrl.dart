// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/countries_api.dart';
import 'package:way_to_doctor_doctor/api/registration/reset_password/step1_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/reset_pass/code_verification_binding.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/model/registration/reset_password/reset_pass_step1_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/forget_password/reset_password_screens/screen2.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../binding/registration/phone_verification_binding.dart';
import '../../../ui/screens/registration/phone_verification/phone_verification_screen.dart';

class ResetPassStep1Controller extends GetxController {
  static ResetPassStep1Controller get find => Get.find();
  static ResetPassStep1Model? resetPassStep1Model;

  Future fetchOtpData({
    required BuildContext context,
    required String phone,
  }) async {
    OverLayLoader.showLoading(context);
    resetPassStep1Model = await ResetPassStep1Api.data(phone: phone);
    if (resetPassStep1Model == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);

      Loader.hide();
      return;
    }
    if (resetPassStep1Model!.code == 200) {
      Get.to(() =>  ResetPassCodeVerificationScreen(skip: MySharedPreferences.skipOtp, verId: MySharedPreferences.verificationId),
          binding: CodeVerificationBinding());
    } else if (resetPassStep1Model!.code == 500) {
      AppConstants().showMsgToast(context, msg: "Code not sent User not found");
    } else {
      AppConstants().showMsgToast(context, msg: resetPassStep1Model!.msg!);
    }
    Loader.hide();
  }

  String currentCountry = '';
  String currentCountryImage = '';
  String currentCountryCode = '';
  int currentCountryDigit = 9;
  int skipOtp = 0;
  void getCurrentCountryCode(String code) {
    currentCountryCode = code;
    MySharedPreferences.countryCode = code;
    update();
  }

  void getCurrentCountry(String country) {
    currentCountry = country;
    MySharedPreferences.country = country;
    update();
  }

  void getCurrentCountryImage(String image) {
    currentCountryImage = image;
    update();
  }

  void getCurrentDigits(int digits, int skip) {
    currentCountryDigit = digits;
    skipOtp = skip;
    MySharedPreferences.countryDigits = digits;
    MySharedPreferences.skipOtp = skip;
    log(MySharedPreferences.skipOtp.toString());
    update();
  }

  List<Country>? countries;
  CountriesModel? countriesModel;
  Future getCountriesList({required BuildContext context}) async {
    OverLayLoader.showLoading(context);

    countriesModel = await CountryListApi.data();
    if (countriesModel == null) {
      Loader.hide();
      return;
    }
    if (countriesModel!.code == 200) {
      countries = countriesModel!.countries;
      currentCountry = countries![0].name.toString();
      currentCountryCode = countries![0].code.toString();
      currentCountryImage = countries![0].image.toString();
      skipOtp = countries![0].skipOtp!;

      update();
    } else if (countriesModel!.code == 500) {
    } else {}
    Loader.hide();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdForSms = '';
  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
 print('number $number');
 // OverLayLoader.showLoading(context);

 await _auth.verifyPhoneNumber(
   phoneNumber: number,
   verificationCompleted: (PhoneAuthCredential credential) async {
     log(number);
     UserCredential userCredential =
     await _auth.signInWithCredential(credential);
     User? user = userCredential.user;
     // do something with the authenticated user
   },
   verificationFailed: (FirebaseAuthException e) {
     log('verificationFailed');
     log(e.message.toString());
     if (e.code == 'invalid-phone-number') {
       log('The provided phone number is not valid.');
     }else{

     }
     // handle other errors as needed
     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
     Loader.hide();
   },
   codeSent: (String verificationId, int? resendToken) {
     log('codeSent');
     verificationIdForSms = verificationId;
     log(verificationIdForSms);
     update();
     Get.to(
             () => ResetPassCodeVerificationScreen(
           skip: 1,
           verId: verificationId,
         ),
         binding: CodeVerificationBinding());

     AppConstants().showMsgToast(context, msg: 'code was sent');
     Loader.hide();

     // store the verification ID somewhere
     // navigate to the screen where the user enters the verification code
   },
   codeAutoRetrievalTimeout: (String verificationId) {
     log('codeAutoRetrievalTimeout');
     // handle the timeout as needed
   },
 );
  }
}
