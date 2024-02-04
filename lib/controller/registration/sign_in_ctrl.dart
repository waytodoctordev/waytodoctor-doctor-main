// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/view_clinic_by_user_id_api.dart';
import 'package:way_to_doctor_doctor/api/registration/clinic_login_api.dart';
import 'package:way_to_doctor_doctor/api/registration/countries_api.dart';
import 'package:way_to_doctor_doctor/api/registration/doctor_login_api.dart';
import 'package:way_to_doctor_doctor/api/registration/get_step_api.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_verification_binding.dart';
import 'package:way_to_doctor_doctor/model/clinic_login/clinic_login_model.dart';
import 'package:way_to_doctor_doctor/model/doctor_login/doctor_login_model.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/model/registration/sign_in_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/ui/base/for_clinic/clinic_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/check_practice/widgets/check_practice_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/phone_verification/phone_verification_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/subscription_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/widgets/registration_end.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../api/notifications/device_token_services.dart';
import '../../model/clinic_login/view_vclinic_by_user_id_model.dart';

class SignInCtrl extends GetxController {
  static SignInCtrl get find => Get.find();
  RxBool signInVar = true.obs;
  RxString activeButton = 'button0'.obs;
  UserModel? userModel;
  bool checkLanguage(){
    if(MySharedPreferences.language == 'en'|| MySharedPreferences.language == 'tr'){
      return signInVar.value;
    }
    else{
      return !signInVar.value;
    }
  }
  Future getStepAndSubscribtionInfo({
    required String token,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    userModel = await GetStepApi.getStepAndQuestion(token: token);
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }

    if (userModel!.code == 200) {
      MySharedPreferences.step = userModel!.user!.step.toString();
      MySharedPreferences.active = userModel!.user!.active.toString();
      MySharedPreferences.formCurrentIndex =
          int.parse(userModel!.user!.questionNumber.toString());
      MySharedPreferences.formIndicatorCurrentIndex =
          int.parse(userModel!.user!.questionNumber.toString());
      // to insure that the user has subscriped
      MySharedPreferences.subscriptionId =
          userModel!.user!.subscriptionId!.toString();
      MySharedPreferences.isSubscriped = userModel!.user!.isSubscriped!;
      isBlock = userModel!.user!.isBlock!;
      // print('step ::${userModel!.user!.step.toString()}');
      // print('active ::${userModel!.user!.active.toString()}');
      update();
      Loader.hide();
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
  }

  bool isBlock = false;

  DoctorLoginModel? doctorLoginModel;
  Future fetchDoctorLoginData({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    doctorLoginModel =
    await DoctorLoginApi().data(phone: phone, password: password);
    if (doctorLoginModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorLoginModel!.code == 200) {
      MySharedPreferences.accessToken = doctorLoginModel!.data!.token!;
      MySharedPreferences.userId =
      doctorLoginModel!.data!.doctorLogindata!.userId!;
      await getStepAndSubscribtionInfo(
        token: doctorLoginModel!.data!.token!,
        context: context,
      );
      MySharedPreferences.id = doctorLoginModel!.data!.doctorLogindata!.id!;
      print('MySharedPreferences.id ${MySharedPreferences.id}');
      MySharedPreferences.userId =
      doctorLoginModel!.data!.doctorLogindata!.userId!;
      MySharedPreferences.clinicUserID =
          doctorLoginModel!.data!.doctorLogindata!.clinicUserId.toString();
      MySharedPreferences.fName =
      doctorLoginModel!.data!.doctorLogindata!.name!;
      MySharedPreferences.email =
      doctorLoginModel!.data!.doctorLogindata!.email!;
      MySharedPreferences.userNumber =
      doctorLoginModel!.data!.doctorLogindata!.phone!;
      MySharedPreferences.userImage =
      doctorLoginModel!.data!.doctorLogindata!.image!;
      MySharedPreferences.address =
      doctorLoginModel!.data!.doctorLogindata!.address!;
      MySharedPreferences.categoryId =
      doctorLoginModel!.data!.doctorLogindata!.categoryId!;
      MySharedPreferences.categoryName =
      doctorLoginModel!.data!.doctorLogindata!.categoryName!;
      MySharedPreferences.userCount =
      doctorLoginModel!.data!.doctorLogindata!.userCount!;
      MySharedPreferences.rating =
      doctorLoginModel!.data!.doctorLogindata!.rating!;
      MySharedPreferences.experience =
      doctorLoginModel!.data!.doctorLogindata!.experience!;
      MySharedPreferences.description =
      doctorLoginModel!.data!.doctorLogindata!.description!;
      MySharedPreferences.lat = doctorLoginModel!.data!.doctorLogindata!.lat!;
      MySharedPreferences.long = doctorLoginModel!.data!.doctorLogindata!.long!;
      MySharedPreferences.doctorClinicId =
      doctorLoginModel!.data!.doctorLogindata!.categoryId!;
      MySharedPreferences.subscriptionId= doctorLoginModel!.data!.doctorLogindata!.subscriptionId.toString();
      print('MySharedPreferences.subscriptionId ${MySharedPreferences.subscriptionId}');
      MySharedPreferences.password = password;
      FirebaseMessaging.instance.getToken().then((value) async {
        MySharedPreferences.deviceToken = value!;
        // log("deviceToken******************:: $value");
        if (MySharedPreferences.accessToken.isNotEmpty) {
          DeviceTokenService().updateDeviceToken(value);
        }
      });
      if (isBlock) {
        AppConstants()
            .showMsgToast(context, msg: 'This user does not exist'.tr);
      } else {
        if (MySharedPreferences.active == '0') {
          MySharedPreferences.lastScreen = 'PhoneVerificationScreen';
          Get.offAll(() => const PhoneVerificationScreen(),
              binding: PhoneVerificationBinding());
        } else {
          if (MySharedPreferences.step == '0') {
            MySharedPreferences.lastScreen = 'RegistrationEnd';
            Get.offAll(() => const RegistrationEnd());
          }
          if (MySharedPreferences.step == '1') {
            MySharedPreferences.lastScreen = 'SubscriptionEnd';
            Get.offAll(() => const SubscriptionEnd());
          }
          if (MySharedPreferences.step == '2') {
            MySharedPreferences.lastScreen = 'CheckPracticeEndScreen';
            Get.to(() => const CheckPracticeEndScreen());
          }
          if (MySharedPreferences.step == '3') {
            MySharedPreferences.lastScreen = 'SpecializationEndScreen';
            Get.to(() => const SpecializationEndScreen());
          }
          if (MySharedPreferences.step == '4') {
            MySharedPreferences.isDoctor = true;
            MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
            Get.offAll(() => const DoctorBaseNavBar(),
                binding: DoctorBaseNavBarBinding());
          }
        }
        MySharedPreferences.isDoctor = true;
      }
    } else if (doctorLoginModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: doctorLoginModel!.msg!);
    } else {
      AppConstants().showMsgToast(context, msg: doctorLoginModel!.msg!);
    }
    Loader.hide();
  }

  ClinicLoginModel? clinicLoginModel;
  SignInModel? signInModel;
  Future clinicLogin({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    signInModel = await ClinicLoginApi().data(phone: phone, password: password);
    if (signInModel == null) {
      log('null');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (signInModel!.code == 200) {
      log(signInModel!.data!.user!.id.toString());
      await fetchClinicLoginData(
          userId: signInModel!.data!.user!.id.toString(),
          context: context,
          phone: '${phone}0',
          token: signInModel!.data!.token.toString(),
          email: signInModel!.data!.user!.email.toString());
    } else if (signInModel!.code == 500) {
      log('500');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      log('else');
      AppConstants().showMsgToast(context, msg: signInModel!.msg!);
    }
    Loader.hide();
  }

  ViewClinicByUserIdModel? viewClinicByUserIdModel;
  Future fetchClinicLoginData({
    required String userId,
    required String token,
    required String email,
    required String phone,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    viewClinicByUserIdModel = await ViewClinicByUserIdApi.data(userId: userId);
    if (viewClinicByUserIdModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (viewClinicByUserIdModel!.code == 200) {
      MySharedPreferences.accessToken = token;
      MySharedPreferences.userId = int.parse(userId);
      await getStepAndSubscribtionInfo(
        token: token,
        context: context,
      );
      MySharedPreferences.id = viewClinicByUserIdModel!.data.id;
      MySharedPreferences.userId = int.parse(userId);
      MySharedPreferences.fName = viewClinicByUserIdModel!.data.name;
      MySharedPreferences.email = email;
      MySharedPreferences.userNumber = phone;
      MySharedPreferences.address = viewClinicByUserIdModel!.data.address;
      MySharedPreferences.lat = viewClinicByUserIdModel!.data.lat;
      MySharedPreferences.long = viewClinicByUserIdModel!.data.long;
      if (isBlock) {
        MySharedPreferences.language == 'ar'
            ? AppConstants()
                .showMsgToast(context, msg: 'هذا المستخدم غير موجود')
            : AppConstants()
                .showMsgToast(context, msg: 'This user does not exist');
      } else {
        MySharedPreferences.isDoctor = false;
        MySharedPreferences.lastScreen = 'ClinicBaseNavBar';
        Get.offAll(() => const ClinicBaseNavBar(),
            binding: ClinicBaseNavBarBinding());
      }

      await FirebaseMessaging.instance.getToken().then((value) async {
        MySharedPreferences.deviceToken = value!;
        log("deviceToken###########################:: $value");
        if (MySharedPreferences.accessToken.isNotEmpty) {
          await DeviceTokenService().updateDeviceToken(value);
        }
      });
    } else if (doctorLoginModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: viewClinicByUserIdModel!.msg);
    }
    Loader.hide();
  }

  String currentCountry = '';
  String currentCountryImage = '';
  RxString currentCountryCode = ''.obs;
  int currentCountryDigit = 9;

  void getCurrentCountryCode(String code) {
    currentCountryCode.value = code;
    MySharedPreferences.countryCode=code;
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

  void getCurrentDigits(int digits) {
    currentCountryDigit = digits;
    MySharedPreferences.countryDigits = digits;
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
      Loader.hide();
      countries = countriesModel!.countries;
      currentCountry = countries![0].name.toString();
      currentCountryCode.value = countries![0].code.toString();
      currentCountryImage = countries![0].image.toString();
      currentCountryDigit = countries![0].digits!;
      MySharedPreferences.countryDigits = currentCountryDigit;
      MySharedPreferences.countryCode = countries![0].code!;
      print(' MySharedPreferences.countryCode ${ MySharedPreferences.countryCode}');

      update();
    } else if (countriesModel!.code == 500) {
    } else {}
  }


}
