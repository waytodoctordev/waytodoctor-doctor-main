// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/countries_api.dart';
import 'package:way_to_doctor_doctor/api/registration/update_number_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_verification_binding.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/model/registration/update_number_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/phone_verification/phone_verification_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateNumberCtrl extends GetxController {
  static UpdateNumberCtrl get find => Get.find();

  UpdateNumberModel? updateNumberModel;
  late TextEditingController phoneNumberCtrl;

  Future fetchUpdateNumber(
      {required String phone,
      required String userID,
      required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    updateNumberModel =
    await UpdateNumberApi().data(phone: phone, userID: userID);//otp?
    if (updateNumberModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (updateNumberModel!.code == 200) {
      if (skipOtp == 0) {
        log(MySharedPreferences.countryCode);
        MySharedPreferences.lastScreen = 'PhoneVerificationScreen';
        Get.to(() => const PhoneVerificationScreen(),
            binding: PhoneVerificationBinding());
        AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
        Loader.hide();
      } else {
        await verifyPhoneNumber(context, phone);

        // SendOtpCtrl.find.fetchOtpData(
        //   context: context,
        //   phone: phone,
        //   code: '1761995',
        // );
      }
    } else if (updateNumberModel!.code == 500) {
      Loader.hide();
      AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
    } else {
      AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
      Loader.hide();
    }
  }

  String currentCountry = '';
  String currentCountryImage = '';
  String currentCountryCode = '';
  int currentCountryDigit = 9;
  int skipOtp = 0;

  void getCurrentCountryCode(String code) {
    currentCountryCode = code;
    MySharedPreferences.countryCode = code;
    log(MySharedPreferences.countryCode);
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
      currentCountryDigit = countries![0].digits!;
      skipOtp = countries![0].skipOtp!;
      MySharedPreferences.countryDigits = currentCountryDigit;
      MySharedPreferences.skipOtp = skipOtp;
      MySharedPreferences.countryCode = countries![0].code.toString();

      update();
    } else if (countriesModel!.code == 500) {
    } else {}
    Loader.hide();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationIdForSms = '';
  Future<void> verifyPhoneNumber(BuildContext context, String number) async {
    OverLayLoader.showLoading(context);

    log(number);
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
        if (e.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
        // handle other errors as needed
        AppConstants().showMsgToast(context,
            msg: e.message ?? AppConstants.failedMessage);
        Loader.hide();
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdForSms = verificationId;
        log(verificationIdForSms);
        update();
        MySharedPreferences.verificationId = verificationId;
        MySharedPreferences.lastScreen = 'PhoneVerificationScreen';
        Get.to(() => PhoneVerificationScreen(veriId: verificationId),
            binding: PhoneVerificationBinding());

        AppConstants().showMsgToast(context, msg: 'code was sent');
        Loader.hide();

        // store the verification ID somewhere
        // navigate to the screen where the user enters the verification code
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // handle the timeout as needed
      },
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    phoneNumberCtrl = TextEditingController();
  }

  @override
  void onClose() {
    phoneNumberCtrl.dispose();
    super.onClose();
  }
}
