import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/specialization_certificate/specialization_certificate_screen.dart';
import '../../api/for_center/edit_center_info.dart';
import '../../api/notifications/device_token_services.dart';
import '../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../model/categories/categories_model.dart';
import '../../model/center/category_centers.dart';
import '../../model/center/center_login_model.dart';
import '../../model/center/edit_center_info_model.dart';
import '../../model/create_certificate/create_certificate_mode.dart';
import '../../model/home_screen/doctors_model.dart';
import '../../model/mainModel.dart';
import '../../services/api_request_handlers/api_service.dart';
import '../../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../../ui/widgets/overlay_loader.dart';
import '../../utils/api_url.dart';
import '../../utils/app_constants.dart';
import '../../utils/shared_prefrences.dart';

class CenterCtrl extends GetxController {
  static CenterCtrl get find => Get.find();
  ApiService apiRequestService = ApiService();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // getCategoriesList();
    super.onInit();
  }

  /// VARIABLES
  String currentCountry = '';
  String currentCountryImage = '';
  String categoryImage = '';
  String categoryName = '';
  bool isLoading = true;
  int currentCountryDigit = 9;
  int categoryID = 0;
  int centerId = 0;

  /// OBSERVABLE VARIABLES
  RxString currentCountryCode = ''.obs;
  RxString centerProfileImage = ''.obs;
  RxString centerName = ''.obs;
  RxString categoriesName = ''.obs;
  RxInt categoriesID = 0.obs;
  RxInt centerID = 0.obs;
  String centerCategoryId = '';
  RxInt categoryCenterId = 0.obs;
  RxInt categoryCenterName = 0.obs;
  bool centerDoctorsLength = false;
  RxBool categoriesLength = false.obs;

  /// SIGN IN TEXT FIELDS
  final TextEditingController phoneNumberCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  /// SIGN UP TEXT FIELDS
  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController centerAddressCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
  final TextEditingController centerEmailCtrl = TextEditingController();

  /// MODELS
  List<Categories>? categories;
  CategoriesModel? categoryModel;
  CategoryCenters? categoryCentersModel;
  List<CategoryCentersData>? categoryCentersList;
  EditCenterInfoModel? joiningToCenterModel;
  CenterLoginModel? centerLoginModel;
  CenterLoginModel? centerSignUpModel;
  CentersModel? doctorsCentersModel;
  MainModel? changeActivityStatus;
  CreateCertificateModel? createCertificateModel;
  EditCenterInfoModel? profLicense;

  /// METHODS AND FUNCTIONS
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning'.tr;
    } else {
      return 'Good evening'.tr;
    }
  }

  /// DONE . => CATEGORIES LIST CONTAINER API REPLACED WITH OLD CenterCategories API
  Future getCategoriesList(BuildContext context) async {
    // OverLayLoader.showLoading(context);
    try {
      categoryModel = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.centerCategories}',
          fromJson: (json) => CategoriesModel.fromJson(json));
      if (categoryModel == null) {
        print('categoryModel == null ${categoryModel == null}');
        Loader.hide();
        return;
      }
      if (categoryModel!.code == 200) {
        print('worked');
        Loader.hide();
        categories = categoryModel!.data;
        categoriesName.value = categories![0].name!;
        categoryName = categories![0].name.toString();
        categoriesID.value = categories![0].id!;
        MySharedPreferences.centerCategoryID = categories![0].id!.toString();
        categoriesLength.value = true;

        MySharedPreferences.isDoctor
            ? await getCategoriesCentersList(context: context)
            : null;
        // MySharedPreferences.countryDigits = currentCountryDigit;
        isLoading = false;
        update();
      }
    } catch (error) {
      print('error with hate');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => CATEGORIES LIST CONTAINER API REPLACED WITH OLD CategoryCentersApi API
  Future getCategoriesCentersList({required BuildContext context}) async {
    try {
      categoryCentersModel = await apiRequestService.makeRequest(
          method: AppConstants.getMethod,
          url:
              '${ApiUrl.mainUrl}${ApiUrl.categoryCenters}/${MySharedPreferences.centerCategoryID}',
          fromJson: (json) => CategoryCenters.fromJson(json));
      // var categoryCentersModel = await CategoryCentersApi.data();

      if (categoryCentersModel!.code == 200) {
        Loader.hide();
        categoryCentersList = categoryCentersModel!.data!;
        centerID.value = categoryCentersList![0].id!;
        isLoading = false;
        update();
      }
    } catch (error) {
      print(error);
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => joining to center button API REPLACED WITH OLD JoiningToCenterApi API
  Future joinDoctorToCenter({
    required String doctorId,
    required String centerId,
    required BuildContext context,
  }) async {
    try {
      joiningToCenterModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.joiningToCenter}',
          fromJson: (json) => EditCenterInfoModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'X-localization': MySharedPreferences.language,
            'authorization': MySharedPreferences.accessToken,
          },
          body: {
            "doctor_id": doctorId,
            "center_id": centerId,
          });

      if (joiningToCenterModel!.code == 200) {
        MySharedPreferences.centerID =
            joiningToCenterModel!.data!.id!.toString();
        centerName.value = joiningToCenterModel!.data!.name!;
        MySharedPreferences.centerCategoryID =
            joiningToCenterModel!.data!.centerCategoryId!;
        Get.offAll(() => const DoctorBaseNavBar(),
            binding: DoctorBaseNavBarBinding());
        Loader.hide();
      } else {
        AppConstants().showMsgToast(context, msg: joiningToCenterModel!.msg!);
      }
      Loader.hide();
    } catch (error) {
      OverLayLoader.showLoading(context);
      print(error);
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => LOGIN CENTER BUTTON  API REPLACED WITH OLD CenterLoginApi API
  Future centerLogin({
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {
      centerLoginModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.centerSignIn}',
          fromJson: (json) => CenterLoginModel.fromJson(json),
          body: {
            "phone_number": phone,
            "password": password,
          });
      if (centerLoginModel!.code == 200) {
        print('log in center true');
        MySharedPreferences.accessToken = centerLoginModel!.data!.token;
        MySharedPreferences.id = centerLoginModel!.data!.data!.id;
        MySharedPreferences.fName = centerLoginModel!.data!.data!.name;
        MySharedPreferences.userImage =
            '${ApiUrl.mainUrl}/${centerLoginModel!.data!.data!.image}';
        MySharedPreferences.address = centerLoginModel!.data!.data!.address;
        MySharedPreferences.subscriptionId =
            centerLoginModel!.data!.data!.subscriptionId;
        MySharedPreferences.centerCategoryID =
            centerLoginModel!.data!.data!.centerCategoryId;
        MySharedPreferences.userId = centerLoginModel!.data!.data!.userId;
        MySharedPreferences.userNumber =
            centerLoginModel!.data!.data!.phoneNumber;
        MySharedPreferences.centerID =
            centerLoginModel!.data!.data!.id.toString();
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
        Get.offAll(()=>CenterHomeScreen());
      }

    } catch (error) {
      print('error $error');
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => SignUp CENTER BUTTON  API REPLACED WITH OLD CenterSignUpApi API
  Future centerSignUp({
    required String name,
    required String phone,
    required String centerCategoryId,
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {
      centerSignUpModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.centerSignUp}',
          fromJson: (json) => CenterLoginModel.fromJson(json),
          body: {
            'name': name,
            'center_category_id': centerCategoryId,
            "phone_number": phone,
            "password": password,
          },
          context: context);
      print('centerSignUpModel!.code ${centerSignUpModel!.code}');
      print('center_category_id $centerCategoryId');
      print('centerSignUpModel!.code $name');
      print(phone);
      if (centerSignUpModel!.code == 200) {
        MySharedPreferences.accessToken = centerSignUpModel!.data!.token;
        MySharedPreferences.centerID =
            centerSignUpModel!.data!.data!.id.toString();
        print('MySharedPreferences.centerID ${MySharedPreferences.centerID}');
//778877888
        MySharedPreferences.fName = centerSignUpModel!.data!.data!.name;
        MySharedPreferences.userNumber =
            centerSignUpModel!.data!.data!.phoneNumber;
        MySharedPreferences.id = centerSignUpModel!.data!.data!.id;
        MySharedPreferences.centerCategoryID =
            centerSignUpModel!.data!.data!.centerCategoryId;
        print('MySharedPreferences.centerCategoryID ${MySharedPreferences.centerCategoryID}');
        MySharedPreferences.subscriptionId =
            centerSignUpModel!.data!.data!.subscriptionId.toString();
        MySharedPreferences.userId = centerSignUpModel!.data!.data!.userId;
        MySharedPreferences.isSubscriped = centerSignUpModel!.data!.data!.isSub;
        print('  MySharedPreferences.isSubscriped ${  MySharedPreferences.isSubscriped}');

        centerProfileImage.value = centerSignUpModel!.data!.data!.image;
        MySharedPreferences.userImage = centerSignUpModel!.data!.data!.image;
        MySharedPreferences.email = centerSignUpModel!.data!.data!.email;
        centerName.value = centerSignUpModel!.data!.data!.name;
        MySharedPreferences.password = passwordCtrl.text;
        FirebaseMessaging.instance.getToken().then((value) async {
          MySharedPreferences.deviceToken = value!;
          if (MySharedPreferences.accessToken.isNotEmpty) {
            DeviceTokenService().updateDeviceToken(value);
          }
        });
        AppConstants()
            .showMsgToast(context, msg: 'Welcome '.tr + centerName.value);
        Loader.hide();
         Get.to(() => CenterHomeScreen());
        Get.offAll(() => SpecializationScreen());
      }
    } catch (error) {
      print(error);
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }
  }

  /// DONE . => GETTING CENTER'S DOCTORS  API REPLACED WITH OLD DoctorsCenterApi API
  Future<CentersModel?> fetchCenterDoctorsData(
      {required String categoryId,
      required String search,
      required String centerId,
      required BuildContext context}) async {
    try {
      print('fetchDoctorCenterData $categoryId $search $centerId');
      doctorsCentersModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.doctorsCenter}',
          fromJson: (json) => CentersModel.fromJson(json),
          body: {
            "value": search,
            "center_id": centerId,
            "category_id": categoryId,
          });
      if (doctorsCentersModel!.status == true) {
        centerDoctorsLength = true;
        update();
      }
    } catch (error) {
      print(error);
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
    }

    // doctorsCentersModel = await DoctorsCenterApi.data(
    //     categoryId: categoryId,
    //     centerId: centerId,
    //     search: search);
    update();
    return doctorsCentersModel;
  }

  /// DONE . => CHANGE DOCTOR JOINING STATUS SWITCHER BUTTON API REPLACED WITH OLD ChangeActivityStatusApi API
  Future changeActivityStatusRequest({
    required String doctorId,
    required bool activityStatus,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(
      context,
    );
    try {
      changeActivityStatus = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: '${ApiUrl.mainUrl}${ApiUrl.changeActivityStatus}',
          fromJson: (json) => MainModel.fromJson(json),
          body: {
            "doctor_id": doctorId,
            "center_status": activityStatus,
          },
          headers: {
            'Content-Type': 'application/json',
            'X-localization': MySharedPreferences.language,
            'authorization': MySharedPreferences.accessToken,
          });
      print('changeActivityStatus!.status  ${changeActivityStatus!.status}');
      if (changeActivityStatus!.status == true) {
        Loader.hide();
        await fetchCenterDoctorsData(
            categoryId: MySharedPreferences.centerCategoryID,
            search: '',
            centerId: MySharedPreferences.centerID,
            context: context);
        // Get.snackbar("Success".tr, changeActivityStatus!.msg);
        AppConstants()
            .showMsgToast(context, msg: changeActivityStatus!.msg.toString());
      }
    } catch (error) {
      print(error);
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
      return;
    }
    //changeActivityStatus =
    //     await   ChangeActivityStatusApi.request(
    //       doctorId: doctorId,
    //       activityStatus: centerStatus,
    //     );
  }

  Future professionalLicenseRequest(
      {required BuildContext context,
      required String name,
      required String phone,
      File? imageProfile,
      required String address,
      File? professionalLicense,
      bool isEditCenterInfo = false}) async {
    OverLayLoader.showLoading(
      context,
    );
    try {
      profLicense = await EditCenterInfoApi.data(
          name: name,
          address: address,
          phone: phone,
          professionalLicense: professionalLicense,
          imageProfile: imageProfile,
          isEditCenterInfo: isEditCenterInfo);
      if (profLicense!.code == 200) {
        print('profLicense!.code == 200');
        MySharedPreferences.fName = profLicense!.data!.name!;
        MySharedPreferences.address = profLicense!.data!.address!;
        MySharedPreferences.userNumber = profLicense!.data!.phoneNumber!;
        MySharedPreferences.userImage =
            '${ApiUrl.mainUrl}/${profLicense!.data!.image!}';
        Loader.hide();
        update();
        !MySharedPreferences.isDoctor
            ? Get.offAll(
                () => CenterHomeScreen(),
              )
            : update();

        AppConstants()
            .showMsgToast(context, msg: AppConstants.addedSuccessfully);

        return ;
      }
    } catch (error) {
      print(error);
      AppConstants().showMsgToast(context, msg: error.toString());
      Loader.hide();
      return ;
    }
  }
}
