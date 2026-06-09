import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/model/delete_model.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../../services/api_request_handlers/api_service.dart';
import '../../../utils/api_url.dart';
import '../../registration/sign_in_ctrl.dart';

class EditAccountCtrl extends GetxController {
  static EditAccountCtrl get find => Get.find();
  ApiService apiRequestService = ApiService();

  PageController pageCtrl = PageController(initialPage: 0);
  bool isPersonalInformation = true;
  int currentPage = 0;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();

  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController currentPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

//MODELS
  DoctorDetailsModel? doctorDetailsModel;
  UserModel? userModel;
  DeleteModel? deleteModel;

  @override
  void onInit() {
    phoneNumberCtrl = TextEditingController(
        text: MySharedPreferences.userNumber
            .toString()
            .split(MySharedPreferences.countryCode)
            .join());
    super.onInit();
  }

  /// DONE . => update Doctor Information API REPLACED WITH OLD UpdateInformationForDoctorApi API
  Future updateDoctorInformation({
    required String userName,
    required String phone,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {
      doctorDetailsModel = await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url:
          '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences
              .id}',
          fromJson: (json) => DoctorDetailsModel.fromJson(json),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
            'X-localization': MySharedPreferences.language,
          },
          body: {
            "phone": MySharedPreferences.countryCode + phone,
            "name": userName,
          });
      // doctorDetailsModel = await UpdateInformationForDoctorApi.data(
      //     userName: userName, email: 'email', phone: phone);
      if (doctorDetailsModel!.code == 200) {
        MySharedPreferences.userNumber =
            doctorDetailsModel!.data!.phone.toString();
        MySharedPreferences.fName = doctorDetailsModel!.data!.name.toString();
        AppConstants()
            .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
      } else {
        doctorDetailsModel!.msg! == ''
            ? AppConstants()
            .showMsgToast(context, msg: doctorDetailsModel!.msg!)
            : AppConstants()
            .showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      }
    } catch (error) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }

    Loader.hide();
  }
  /// DONE . => update Doctor Password API REPLACED WITH OLD UpdatePasswordApi API
  Future updatePassword({
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {
      userModel = await apiRequestService.makeRequest(
        method: AppConstants.postMethod,
        url:
        '${ApiUrl.mainUrl}${ApiUrl.updateUser}/${MySharedPreferences.userId}',
        fromJson: (json) => UserModel.fromJson(json),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
          'X-localization': MySharedPreferences.language,
        },
        body: {
          "password": password,
        },
      );
      if (userModel!.code == 200) {
        MySharedPreferences.password = password;
        AppConstants()
            .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
        print(
            'is doctor ? nancy look here and jeoluos alaa ${MySharedPreferences
                .isDoctor}');
      } else {
        userModel!.msg == ''
            ? AppConstants().showMsgToast(context, msg: userModel!.msg!)
            : AppConstants()
            .showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
      }
    } catch (error) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
    }
    Loader.hide();
  }
  /// DONE . => DELETE DOCTOR ACCOUNT API REPLACED WITH OLD DeleteAccount API
  Future deleteAccount({
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    try {
      deleteModel = await apiRequestService.makeRequest(
        method: AppConstants.getMethod,
        url: MySharedPreferences.isDoctor
            ? '${ApiUrl.mainUrl}${ApiUrl.deleteAccount}/${MySharedPreferences
            .id}'
            : '${ApiUrl.mainUrl}${ApiUrl.deleteCenter}/${MySharedPreferences
            .centerID}',
        fromJson: (json) => DeleteModel.fromJson(json),
        context: context
      );
      if (deleteModel==null){
        print('nullll');
        AppConstants().showMsgToast(
            context, msg: AppConstants.failedMessage);
    Loader.hide();
      }
      if (deleteModel!.code == 200) {
        Get.back();
        SignInCtrl().logout(context:context);
        // Logout().logout();
        MySharedPreferences.clearProfile();
        Get.deleteAll(force: true);
        Get.offAll(
              () => const RegistrationScreen(),
          binding: RegistrationBinding(),
        );
        Loader.hide();
        return;
      }
    } catch (error) {
     AppConstants().showMsgToast(
          context, msg: error.toString());
      Loader.hide();
    }
    // deleteModel = await DeleteAccount().deleteAccount();
  }

  void getCurrentPage(int index) {
    currentPage = index;
    update();
  }

  void setIsPersonalBool(bool value) {
    isPersonalInformation = value;
    update();
  }

  void toggleCurrentPassword() {
    showCurrentPassword = !showCurrentPassword;
    update();
  }

  void toggleNewPassword() {
    showNewPassword = !showNewPassword;
    update();
  }

  void toggleConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }
}


