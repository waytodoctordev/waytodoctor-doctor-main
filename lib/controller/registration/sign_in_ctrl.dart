import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/model/doctor_login/doctor_login_model.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/model/registration/sign_in_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/ui/base/for_clinic/clinic_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../api/notifications/device_token_services.dart';
import '../../binding/registration/update_number_binding.dart';
import '../../model/clinic_login/view_vclinic_by_user_id_model.dart';
import '../../model/doctor_signup/doctor_signup_model.dart';
import '../../services/api_request_handlers/api_service.dart';
import '../../ui/screens/registration/check_practice/widgets/check_practice_end.dart';
import '../../ui/screens/registration/phone_sign_up/phone_sign_up_screen.dart';
import '../../ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';
import '../../ui/screens/registration/widgets/registration_end.dart';
import '../../utils/api_url.dart';

class SignInCtrl extends GetxController {
  static SignInCtrl get find => Get.find();
  ApiService apiRequestService = ApiService();

  RxBool signInVar = true.obs;
  RxString activeButton = 'button0'.obs;
  String currentCountry = 'Jordan';
  String currentCountryImage = '';
  RxString currentCountryCode = ''.obs;
  RxBool goBack = false.obs;

  int currentCountryDigit = 9;
  int skipOtp = 0;
  bool isBlock = false;
  List<Country>? countries;

// MODELS
  DoctorLoginModel? doctorLoginModel;
  DoctorSignUpModel? doctorSignUpModel;
  SignInModel? signInModel;
  CountriesModel? countriesModel;
  UserModel? userModel;
// FUNCTIONS AND METHODS
  /// DONE . => DOCTOR SIGN IN BUTTON  API REPLACED WITH OLD DoctorLoginApi API
  Future doctorLogin({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    print('phone nad pass not null $phone $password ');

    try {
      doctorLoginModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.doctorSignIn}',
          fromJson: (json) => DoctorLoginModel.fromJson(json),
          body: {
            "phone": phone,
            "password": password,
          },//0797796861
          context: context);
      if (doctorLoginModel!.code == 200) {
        final fbAuth.FirebaseAuth auth = fbAuth.FirebaseAuth.instance;
        print('hey doctorLoginModel!.code==200');
        doctorLoginModel!.data!.token!; //ySharedPreferences.accessToken
        MySharedPreferences.userId =
            doctorLoginModel!.data!.doctorLogindata!.userId!;
        await getStepAndSubscriptionInfo(
          token: doctorLoginModel!.data!.token!,
          context: context,
        );
        MySharedPreferences.accessToken = doctorLoginModel!.data!.token!;
        MySharedPreferences.userId =
            doctorLoginModel!.data!.doctorLogindata!.userId!;
        MySharedPreferences.id = doctorLoginModel!.data!.doctorLogindata!.id!;
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
        MySharedPreferences.long =
            doctorLoginModel!.data!.doctorLogindata!.long!;
        MySharedPreferences.doctorClinicId =
            doctorLoginModel!.data!.doctorLogindata!.categoryId!;
        MySharedPreferences.subscriptionId =
            doctorLoginModel!.data!.doctorLogindata!.subscriptionId.toString();
        MySharedPreferences.step =
            doctorLoginModel!.data!.doctorLogindata!.step.toString();

        MySharedPreferences.password = password;
        if (Platform.isIOS) {
          await Purchases.logIn(MySharedPreferences.userId.toString());
          await Purchases.setAttributes({
            'User ID': MySharedPreferences.userId.toString(),
          });
        }
        await auth.signInWithCustomToken(
            doctorLoginModel!.data!.firebaseToken.toString());

        auth.currentUser;print(auth.currentUser?.uid);

        Get.to(() => const DoctorBaseNavBar(),
            binding: DoctorBaseNavBarBinding());
        if (isBlock) {
          AppConstants()
              .showMsgToast(context, msg: 'This user does not exist'.tr);
          return;
        } else {
          if (MySharedPreferences.active == '0') {
            MySharedPreferences.lastScreen = 'PhoneSignUpScreen';
            Get.to(() => const PhoneSignUpScreen(),
                binding: UpdateNumberBinding());
          } else {
            if (MySharedPreferences.step == '0') {
              MySharedPreferences.lastScreen = 'RegistrationEnd';
              Get.to(() => const RegistrationEnd());
            }
            if (MySharedPreferences.step == '1') {
              MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
              Get.to(() => const DoctorBaseNavBar(),
                  binding: DoctorBaseNavBarBinding());
              // Get.to(() => const SubscriptionEnd());
            }
            if (MySharedPreferences.step == '2') {
              MySharedPreferences.lastScreen = 'CheckPracticeEndScreen';
              Get.to(() => const CheckPracticeEndScreen());
            }
            if (MySharedPreferences.step == '3') {
              MySharedPreferences.lastScreen = 'SpecializationEndScreen';
              Get.to(() => const SpecializationEndScreen());
              //    Get.to(() => const SpecializationScreen(),
              //             binding: SpecializationBinding());
            }
            if (MySharedPreferences.step == '4') {
              MySharedPreferences.isDoctor = true;
              MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
              Get.to(() => const DoctorBaseNavBar(),
                  binding: DoctorBaseNavBarBinding());
            }
          }
        }
        print('MySharedPreferences.step  ${MySharedPreferences.step}');
        Loader.hide();
      }
      if (doctorLoginModel!.code == 500) {
        AppConstants().showMsgToast(context, msg: doctorLoginModel!.msg!);
      }

      Loader.hide();
    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
    Loader.hide();
  }

  /// DONE . => DOCTOR SIGN UP BUTTON  API REPLACED WITH OLD DoctorSignUpApi API
  Future doctorSignUp({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {
      doctorSignUpModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.doctorSignUp}',
          fromJson: (json) => DoctorSignUpModel.fromJson(json),
          body: {
            "phone": email,
            "password": password,
            "email": email,
            "name": name,
          });
      if (doctorSignUpModel!.code == 200) {
        MySharedPreferences.accessToken = doctorSignUpModel!.data!.token!;
        MySharedPreferences.id = doctorSignUpModel!.data!.userDoctor!.id!;
        MySharedPreferences.userId =
            doctorSignUpModel!.data!.userDoctor!.userId!;
        MySharedPreferences.fName = doctorSignUpModel!.data!.userDoctor!.name!;
        MySharedPreferences.email = doctorSignUpModel!.data!.userDoctor!.email!;
        MySharedPreferences.step = doctorSignUpModel!.data!.userDoctor!.step!;
        MySharedPreferences.clinicUserID =
            doctorSignUpModel!.data!.userDoctor!.clinicUserId.toString();
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
        MySharedPreferences.rating =
            doctorSignUpModel!.data!.userDoctor!.rating!;
        MySharedPreferences.experience =
            doctorSignUpModel!.data!.userDoctor!.experience!;
        MySharedPreferences.description =
            doctorSignUpModel!.data!.userDoctor!.description!;
        MySharedPreferences.lat = doctorSignUpModel!.data!.userDoctor!.lat!;
        MySharedPreferences.long = doctorSignUpModel!.data!.userDoctor!.long!;
        MySharedPreferences.doctorClinicId =
            doctorSignUpModel!.data!.userDoctor!.categoryId!;
        MySharedPreferences.password = password;
        MySharedPreferences.lastScreen = 'PhoneSignUpScreen';
        MySharedPreferences.subscriptionId = '';
        fbAuth.User? user = fbAuth.FirebaseAuth.instance.currentUser;
        if (user == null) {
          // Sign in anonymously
          await fbAuth.FirebaseAuth.instance.signInAnonymously();
        } else {
          await fbAuth.FirebaseAuth.instance.signInWithEmailAndPassword(
            email: doctorLoginModel!.data!.doctorLogindata!.email!,
            password: MySharedPreferences.password,
          );
          final uid = user.uid;
          print("Firebase UID: $uid");
        }
        Get.to(() => const PhoneSignUpScreen(), binding: UpdateNumberBinding());
        AppConstants().showMsgToast(context, msg: 'Welcome '.tr + name);
      }
      Loader.hide();
    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => CLINIC SIGN IN BUTTON  API REPLACED WITH OLD ClinicLoginApi API
  Future clinicLogin({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    try {
      OverLayLoader.showLoading(context);
      signInModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.signInUser}',
          fromJson: (json) => SignInModel.fromJson(json),
          body: {
            "phone": '${phone}0',
            "password": password,
          });
      if (signInModel!.code == 200) {
        log(signInModel!.data!.user!.id.toString());
        await fetchClinicData(
            userId: signInModel!.data!.user!.id.toString(),
            context: context,
            phone: '${phone}0',
            token: signInModel!.data!.token.toString(),
            email: signInModel!.data!.user!.email.toString());
      }
    } catch (error) {
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . =>  fetchClinicData BUTTON  API REPLACED WITH OLD ViewClinicByUserIdApi API
  ViewClinicByUserIdModel? viewClinicByUserIdModel;
  Future fetchClinicData({
    required String userId,
    required String token,
    required String email,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      OverLayLoader.showLoading(context);
      viewClinicByUserIdModel = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.viewClinicByUserId}/$userId',
          fromJson: (json) => ViewClinicByUserIdModel.fromJson(json));
      // viewClinicByUserIdModel = await ViewClinicByUserIdApi.data(userId: userId);
      if (viewClinicByUserIdModel == null) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      }
      if (viewClinicByUserIdModel!.code == 200) {
        MySharedPreferences.accessToken = token;
        MySharedPreferences.userId = int.parse(userId);
        await getStepAndSubscriptionInfo(
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
      }
      Loader.hide();
    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  Future<void> logout({required BuildContext context}) async {
    try {
      await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.logout}',
          fromJson: (json) => DoctorSignUpModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
            'X-localization': MySharedPreferences.language,
          });
    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => MULTIPLE QUESTIONS BUTTON  API REPLACED WITH OLD GetStepApi API
  Future getStepAndSubscriptionInfo({
    required String token,
    required BuildContext context,
  }) async {
    try {
      OverLayLoader.showLoading(context);
      print('getStepAndSubscriptionInfo  $token');
      userModel = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url:
              '${ApiUrl.mainUrl}${ApiUrl.profile}/${MySharedPreferences.userId}',
          fromJson: (json) => UserModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
            'X-localization': MySharedPreferences.language,
          });
      if (userModel!.code == 200) {
        MySharedPreferences.step = userModel!.user!.step.toString();
        MySharedPreferences.active = userModel!.user!.active.toString();
        MySharedPreferences.formCurrentIndex =
            int.parse(userModel!.user!.questionNumber.toString());
        MySharedPreferences.formIndicatorCurrentIndex =
            int.parse(userModel!.user!.questionNumber.toString());
        MySharedPreferences.subscriptionId =
            userModel!.user!.subscriptionId!.toString();
        MySharedPreferences.isSubscriped = userModel!.user!.isSubscriped!;
        isBlock = userModel!.user!.isBlock!;
        update();
        Loader.hide();
      }
    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => COUNTRIES LIST BUTTON  API REPLACED WITH OLD CountryListApi API
  Future getCountriesList({required BuildContext context}) async {
    try {
      OverLayLoader.showLoading(context);
      print('getCountriesList');
      countriesModel = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.countries}',
          fromJson: (json) => CountriesModel.fromJson(json));
      if (countriesModel!.code == 200) {
        print(countriesModel!.code == 200);
        print('countriesModel!.code == 200');

        Loader.hide();
        countries = countriesModel!.countries;
        currentCountry = countries![0].name.toString();
        currentCountryCode.value = countries![0].code.toString();
        currentCountryImage = countries![0].image.toString();
        print('currentCountryImage $currentCountryImage');
        currentCountryDigit = countries![0].digits!;
        MySharedPreferences.countryDigits = currentCountryDigit;
        MySharedPreferences.countryCode = countries![0].code!;
        update();
        Loader.hide();
      } else if (countriesModel!.code == 500) {
        print('error countriesModel!.code == 500');
        AppConstants().showMsgToast(context, msg: countriesModel!.msg!);
      }
    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
    update();
  }

  void getCurrentCountryCode(String code) {
    currentCountryCode.value = code;
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
}
