import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_center/edit_center_info.dart';
import 'package:way_to_doctor_doctor/model/main_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';

import '../../api/for_center/category_centers.dart';
import '../../api/for_center/center_signin_api.dart';
import '../../api/for_center/center_signup_api.dart';
import '../../api/for_center/change_activity_status_api.dart';
import '../../api/for_center/joining_to_center_api.dart';
import '../../api/notifications/device_token_services.dart';
import '../../api/registration/center_categories.dart';
import '../../api/registration/countries_api.dart';
import '../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../binding/registration/update_number_binding.dart';
import '../../model/categories/categories_model.dart';
import '../../model/center/category_centers.dart';
import '../../model/center/center_login_model.dart';
import '../../model/center/edit_center_info_model.dart';
import '../../model/registration/countries_model.dart';
import '../../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../../ui/screens/for_center/components/doctor_center_screen.dart';
import '../../ui/screens/registration/phone_sign_up/phone_sign_up_screen.dart';
import '../../ui/widgets/overlay_loader.dart';
import '../../utils/app_constants.dart';
import '../../utils/shared_prefrences.dart';

class CenterCtrl extends GetxController {
  static CenterCtrl get find => Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// SIGN IN FIELDS
  final TextEditingController phoneNumberCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  /// SIGN UP FIELDS
  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController centerAddressCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController centerEmailCtrl = TextEditingController();

  /// VALUES AND VARIABLES
  String currentCountry = '';
  String currentCountryImage = '';
  RxString currentCountryCode = ''.obs;
  int currentCountryDigit = 9;
  String categoryName = '';
  int categoryID = 0;
  String categoryImage = '';

  final passwordRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  @override
  void onInit() {
    super.onInit();
  }

  void getCurrentCountryCode(String code) {
    currentCountryCode.value = code;
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
  Future getCountriesList({required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    var countriesModel = await CountryListApi.data();
    if (countriesModel == null) {
      Loader.hide();
      return;
    }
    if (countriesModel.code == 200) {
      Loader.hide();
      countries = countriesModel.countries;
      currentCountry = countries![0].name.toString();
      currentCountryCode.value = countries![0].code.toString();
      currentCountryImage = countries![0].image.toString();
      currentCountryDigit = countries![0].digits!;
      MySharedPreferences.countryDigits = currentCountryDigit;
      update();
    } else if (countriesModel.code == 500) {
    } else {}
  }

  RxString categoriesName = ''.obs;
  RxInt categoriesID = 0.obs;
  RxInt centerID = 0.obs;
  String centerCategoryId = '';
  RxInt categoryCenterId = 0.obs;
  RxInt categoryCenterName = 0.obs;
  int centerId = 0;
  List<Categories>? categories;
  RxBool categoriesLength = false.obs;
  // RxList categories = [].obs;
  Future getCategoriesList({required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    var categoryModel = await CenterCategories.data();
    if (categoryModel == null) {
      Loader.hide();
      return;
    }
    if (categoryModel.code == 200) {
      print('categoryModel.code == 200');
      Loader.hide();
      categories = categoryModel.data;
      categoriesName.value = categories![0].name!;
      categoryName = categories![0].name.toString();
      categoriesID.value = categories![0].id!;
      MySharedPreferences.centerCategoryID = categories![0].id!.toString();
      categoriesLength.value = true;

      MySharedPreferences.isDoctor
          ? await getCategoriesCentersList(context: context)
          : null;
      // MySharedPreferences.countryDigits = currentCountryDigit;

      update();
    } else if (categoryModel.code == 500) {
    } else {}
  }

  List<CategoryCentersData>? categoryCentersList;

  Future getCategoriesCentersList({required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    var categoryCentersModel = await CategoryCentersApi.data();
    if (categoryCentersModel == null) {
      Loader.hide();
      return;
    }
    if (categoryCentersModel.code == 200) {
      Loader.hide();
      categoryCentersList = categoryCentersModel.data!;
      centerID.value = categoryCentersList![0].id!;
      update();
    } else if (categoryCentersModel.code == 500) {
    } else {
      print('categoryModel.code == unknown');
    }
  }

  Future fetchCenterLoginData({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {

      final centerLoginModel =
          await CenterLoginApi().data(phone: phone, password: password);
      if (centerLoginModel == null) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      }
      if (centerLoginModel.code == 200) {
        MySharedPreferences.accessToken = centerLoginModel!.data!.token;
        MySharedPreferences.id = centerLoginModel!.data!.data!.id;
        MySharedPreferences.fName = centerLoginModel!.data!.data!.name;
        MySharedPreferences.userImage = centerLoginModel!.data!.data!.image;
        MySharedPreferences.address = centerLoginModel!.data!.data!.address;
        MySharedPreferences.subscriptionId =
            centerLoginModel!.data!.data!.subscriptionId;
        MySharedPreferences.centerCategoryID =
            centerLoginModel!.data!.data!.centerCategoryId;
        MySharedPreferences.userId = centerLoginModel!.data!.data!.userId;
        MySharedPreferences.userNumber =
            centerLoginModel!.data!.data!.phoneNumber;
        MySharedPreferences.centerID = centerLoginModel!.data!.data!.id;
        MySharedPreferences.isSubscriped = centerLoginModel!.data!.data!.isSub;
        centerCategoryId = centerLoginModel!.data!.data!.centerCategoryId;
        centerId = centerLoginModel!.data!.data!.id;
        MySharedPreferences.password = passwordCtrl.text;
        FirebaseMessaging.instance.getToken().then((value) async {
          MySharedPreferences.deviceToken = value!;
          log("deviceToken******************:: $value");
          if (MySharedPreferences.accessToken.isNotEmpty) {
            DeviceTokenService().updateDeviceToken(value);
          }
        });
        Loader.hide();
        AppConstants().showMsgToast(context,
            msg: 'Welcome '.tr + MySharedPreferences.fName);
        Get.to(CenterHomeScreen());
      } else if (centerLoginModel.code == 500) {
        print('centerLoginModel.code == 500');
        AppConstants().showMsgToast(context, msg: centerLoginModel.msg);
      } else {
        AppConstants().showMsgToast(context, msg: centerLoginModel.msg);
      }
    } catch (e) {
      AppConstants().showMsgToast(context, msg: e.toString());
    }

    Loader.hide();
  }

  RxString centerProfileImage = ''.obs;
  RxString centerName = ''.obs;
  Future fetchCenterSignUpData({
    required String name,
    // required String address,
    required String phone,
    required String centerCategoryId,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    final centerSignUpModel = await CenterSignUpApi().data(
      name: name,
      // address: '',
      phone: phone,
      centerCategoryId: centerCategoryId,
      password: password,
    );
    if (centerSignUpModel == null) {
      AppConstants()
          .showMsgToast(context, msg: 'User has been already regirsted'.tr);
      // AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (centerSignUpModel!.code == 200) {
      MySharedPreferences.accessToken = centerSignUpModel!.data!.token;
      MySharedPreferences.centerID = centerSignUpModel!.data!.data!.id;
      MySharedPreferences.fName = centerSignUpModel!.data!.data!.name;
      // MySharedPreferences.address=centerSignUpModel!.data.data.address;
      MySharedPreferences.userNumber =
          centerSignUpModel!.data!.data!.phoneNumber;
      MySharedPreferences.id = centerSignUpModel!.data!.data!.id;
      MySharedPreferences.centerCategoryID =
          centerSignUpModel!.data!.data!.centerCategoryId;
      MySharedPreferences.subscriptionId =
          centerSignUpModel!.data!.data!.subscriptionId.toString();
      MySharedPreferences.userId = centerSignUpModel!.data!.data!.userId;
      MySharedPreferences.isSubscriped = centerSignUpModel!.data!.data!.isSub;
      centerProfileImage.value = centerSignUpModel!.data!.data!.image;
      MySharedPreferences.userImage = centerSignUpModel!.data!.data!.image;
      centerName.value = centerSignUpModel!.data!.data!.name;
      MySharedPreferences.password = passwordCtrl.text;
      FirebaseMessaging.instance.getToken().then((value) async {
        MySharedPreferences.deviceToken = value!;
        log("deviceToken******************:: $value");
        if (MySharedPreferences.accessToken.isNotEmpty) {
          DeviceTokenService().updateDeviceToken(value);
        }
      });
      AppConstants()
          .showMsgToast(context, msg: 'Welcome '.tr + centerName.value);
      Loader.hide();
      // Get.to(() => const PhoneSignUpScreen(), binding: UpdateNumberBinding());
      Get.to(
        () => CenterHomeScreen(),
      );
    } else if (centerSignUpModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: centerSignUpModel!.msg);
    } else {
      AppConstants().showMsgToast(context, msg: centerSignUpModel!.msg);
    }
    Loader.hide();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning'.tr;
    } else {
      return 'Good evening'.tr;
    }
  }

  EditCenterInfoModel? joiningToCenterModel;
  Future joinDoctorToCenter({
    required String doctorId,
    required String centerId,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    joiningToCenterModel = await JoiningToCenterApi.request(
      doctorId: doctorId,
      centerId: centerId,
    );
    if (joiningToCenterModel == null) {
      print('joiningToCenterModel == null');
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      // AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (joiningToCenterModel!.code == 200) {
      MySharedPreferences.centerID = joiningToCenterModel!.data!.id!;
      centerName.value = joiningToCenterModel!.data!.name!;
      MySharedPreferences.centerCategoryID =
          joiningToCenterModel!.data!.centerCategoryId!;
      Get.offAll(() => const DoctorBaseNavBar(),
          binding: DoctorBaseNavBarBinding());
      // AppConstants().showMsgToast(context, msg: joiningToCenterModel!.msg!);
      Loader.hide();
    } else if (joiningToCenterModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: joiningToCenterModel!.msg!);
      Loader.hide();
    } else {
      AppConstants().showMsgToast(context, msg: joiningToCenterModel!.msg!);
    }
    Loader.hide();
  }
}
