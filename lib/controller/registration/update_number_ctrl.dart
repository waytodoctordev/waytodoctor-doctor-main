import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/registration/countries_api.dart';
import 'package:way_to_doctor_doctor/binding/registration/phone_verification_binding.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/model/registration/update_number_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/phone_verification/phone_verification_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../services/api_request_handlers/api_service.dart';
import '../../utils/api_url.dart';

class UpdateNumberCtrl extends GetxController {
  static UpdateNumberCtrl get find => Get.find();
  ApiService apiRequestService =ApiService();

  UpdateNumberModel? updateNumberModel;
  TextEditingController phoneNumberCtrl = TextEditingController();
  /// DONE . => SEND OTP CODE BUTTON API REPLACED WITH OLD UpdateNumberApi API

  ///UpdateNumberApi
  Future fetchUpdateNumber(
      {required String phone,
      required String userID,
      required BuildContext context}) async {
    print('fetchUpdateNumber');
    OverLayLoader.showLoading(context);
    try{
      updateNumberModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.updateUserNumber}',
          fromJson: (json)=>UpdateNumberModel.fromJson(json),
          body: {
            "phone": phone,
            'active': '2',
            'email':MySharedPreferences.email
          },context:context
      )
          ;
      if (updateNumberModel!.code == 200) {
        if (MySharedPreferences.skipOtp == 0) {
          print('skip otp ${MySharedPreferences.skipOtp}');
          // log(MySharedPreferences.countryCode);
          MySharedPreferences.lastScreen = 'PhoneVerificationScreen';
          Get.to(() => const PhoneVerificationScreen(),
              binding: PhoneVerificationBinding());
          AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
          Loader.hide();
        } else {
                    print('skip otp $skipOtp');

          await verifyPhoneNumber(context, phone);
          Loader.hide();

          // SendOtpCtrl.find.fetchOtpData(
          //   context: context,˚˚
          //   phone: phone,
          //   code: '1761995',
          // );
        }
      }
      else if (updateNumberModel!.code == 500) {
        print('we returned ');
    final errorMessage = updateNumberModel!.msg!?? 'Unexpected error';
    throw errorMessage;}
    else{
      print('elseeee');
        updateNumberModel!.msg ==''
            ? AppConstants().showMsgToast(context, msg: AppConstants.failedMessage)
            : AppConstants().showMsgToast(context, msg: updateNumberModel!.msg!);
        Loader.hide();
      }
    }catch(error){

      print('error catching error $error}');
                   AppConstants().showMsgToast(context, msg: error.toString());

      // AppConstants().showMsgToast(context, msg: 'phone number already exists'.tr);
      Loader.hide();
      return;
    }
    print('skip otp ${MySharedPreferences.skipOtp}');

    // updateNumberModel =
    // await UpdateNumberApi().data(phone: phone, userID: userID);//otp?


  }

  String currentCountry = '';
  String currentCountryImage = '';
  RxString currentCountryCode = ''.obs;

  // String currentCountryCode = '';
  int currentCountryDigit = 9;
  int skipOtp = 0;

  void getCurrentCountryCode(String code) {
    currentCountryCode.value = code;
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
      currentCountryCode.value = countries![0].code.toString();
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
    print(number);
    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('verifyPhoneNumber');
        try {
           print('try');
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
         print('try');
    User? user = userCredential.user;
    
 print('$user');
    if (context.mounted) {
               print('try');

      // navigate or update UI safely here
    }
  } catch (e, stack) {
    print('Auth error: $e');
    print('Stack trace: $stack');
  }
        // UserCredential userCredential =
        //     await _auth.signInWithCredential(credential);
        // User? user = userCredential.user;
        // do something with the authenticated user
      },
      verificationFailed: (FirebaseAuthException e) {
        String userMessage;

        switch (e.code) {
          case 'invalid-phone-number':
            userMessage =
                "The phone number format is invalid. Please enter a valid number.";
            break;
          case 'too-many-requests':
            userMessage =
                "Too many attempts. Please wait a few minutes before trying again.";
            break;
          case 'network-request-failed':
            userMessage =
                "Network error. Please check your internet connection and try again.";
            break;
          case 'captcha-check-failed':
          case 'app-not-authorized':
          case 'internal-error':
            userMessage =
                "We couldn’t verify your phone number. Please try again later.";
            break;
          default:
            userMessage = "Something went wrong. Please try again later.";        }

        AppConstants().showMsgToast(context, msg: userMessage);
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
