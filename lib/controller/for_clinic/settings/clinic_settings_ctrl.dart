// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/clinic_settings/clinic_work_hours_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/clinic_settings/update_communication_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/clinic_settings/update_password_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/clinic_settings/update_personal_into_api.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/clinic_settings/update_work_hours_for_clinic_api.dart';
import 'package:way_to_doctor_doctor/model/clinic_model/clinic_model.dart';
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_data_model.dart';
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ClinicSettingsCtrl extends GetxController {
  static ClinicSettingsCtrl get find => Get.find();
  late PageController pageController;
  bool isPersonalInformation = true;
  int currentPage = 0;
  PageController pageCtrl = PageController(initialPage: 0);
  void getCurrentPage(int index) {
    currentPage = index;
    update();
  }

  void setIsPersonalBool(bool value) {
    isPersonalInformation = value;
    update();
  }

  RxBool showLoader=false.obs;
  late TextEditingController nameCtrl;
  late TextEditingController phoneNumberCtrl;
  late TextEditingController addressCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController newPasswordCtrl;
  late TextEditingController currentPasswordCtrl;
  late TextEditingController confirmPasswordCtrl;
  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> communicationFormKey = GlobalKey<FormState>();

  bool showCurrentPassword = false;
  bool showNewPassword = false;
  bool showConfirmPassword = false;

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

  List<String> settingsTabbarItems = [
    'work hours'.tr,
    'communication'.tr,
    'account'.tr,
  ];

  int currentTabbrIndex = 0;
  void getCurrentTabbarIndex(int value) {
    currentTabbrIndex = value;
    currentPage = 0;
    isPersonalInformation = true;
    update();
  }

  void changeSettingsPage(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  initWorkHours() {
    initializeWorkHoursForDoctor = fetchDoctorWorkHours();
  }

  WorkHoursModel? workHoursModel;
  List<WorkHoursData>? workHours;
  late Future<WorkHoursModel?> initializeWorkHoursForDoctor;
  Future<WorkHoursModel?> fetchDoctorWorkHours() async {
    workHoursModel = await WorkHoursForClinicApi.data();
    if (workHoursModel!.code == 200) {
      workHours = workHoursModel!.data;
      if (workHours!.length == 7) {
        // saturday : -
        saturdayId = workHours![0].id.toString();
        saturdayFromHour = workHours![0].startAt.toString();
        saturdayToHour = workHours![0].endAt.toString();
        workHours![0].status! == 0
            ? saturdayStatus = false
            : saturdayStatus = true;

        // sunday : -
        sundayId = workHours![1].id.toString();
        sundayFromHour = workHours![1].startAt.toString();
        sundayToHour = workHours![1].endAt.toString();
        workHours![1].status! == 0 ? sundayStatus = false : sundayStatus = true;

        // monday : -
        mondayId = workHours![2].id.toString();
        mondayFromHour = workHours![2].startAt.toString();
        mondayToHour = workHours![2].endAt.toString();
        workHours![2].status! == 0 ? mondayStatus = false : mondayStatus = true;

        // tuesday : -
        tuesdayId = workHours![3].id.toString();
        tuesdayFromHour = workHours![3].startAt.toString();
        tuesdayToHour = workHours![3].endAt.toString();
        workHours![3].status! == 0
            ? tuesdayStatus = false
            : tuesdayStatus = true;

        // wednesday : -
        wednesdayId = workHours![4].id.toString();
        wednesdayFromHour = workHours![4].startAt.toString();
        wednesdayToHour = workHours![4].endAt.toString();
        workHours![4].status! == 0
            ? wednesdayStatus = false
            : wednesdayStatus = true;

        // thursday : -
        thursdayId = workHours![5].id.toString();
        thursdayFromHour = workHours![5].startAt.toString();
        thursdayToHour = workHours![5].endAt.toString();
        workHours![5].status! == 0
            ? thursdayStatus = false
            : thursdayStatus = true;

        // friday : -
        fridayId = workHours![6].id.toString();
        fridayFromHour = workHours![6].startAt.toString();
        fridayToHour = workHours![6].endAt.toString();
        workHours![6].status! == 0 ? fridayStatus = false : fridayStatus = true;
      } else {}
      return workHoursModel;
    }
    return null;
  }

  WorkHoursDataModel? workHoursDataModel;
  Future updateWorkHours(
      {required String dayId,
      required String from,
      required String to,
      required String status,
      required BuildContext context}) async {
    if(showLoader.value){
    OverLayLoader.showLoading(context);
  }

      workHoursDataModel = await UpdateWorkHoursForClinicApi.data(
        dayId: dayId,
        from: from,
        to: to,
        status: status,
      );
      if (workHoursDataModel == null) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Loader.hide();
        return;
      }
      if (workHoursDataModel!.code == 200) {
      }
      else if (workHoursDataModel!.code == 500) {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      } else {
        AppConstants().showMsgToast(context, msg: workHoursDataModel!.msg!);
      }
    if(!showLoader.value){
      Loader.hide();
    }



  }

  // saturday : -
  String saturdayId = '';

  String saturdayFromHour = 'Am 10:00';
  String saturdayToHour = 'PM 05:00';
  bool saturdayStatus = false;

  void getSaturdayFromHour(String fromHour) {
    saturdayFromHour = fromHour;
    update();
  }

  void getSaturdayToHour(String toHour) {
    saturdayToHour = toHour;
    update();
  }

  void getSaturdayStatus(bool value) {
    saturdayStatus = value;
    update();
  }

  // sunday : -
  String sundayId = '';

  String sundayFromHour = 'Am 10:00';
  String sundayToHour = 'PM 05:00';
  bool sundayStatus = false;

  void getSundayFromHour(String fromHour) {
    sundayFromHour = fromHour;
    update();
  }

  void getSundayToHour(String toHour) {
    sundayToHour = toHour;
    update();
  }

  void getSundayStatus(bool value) {
    sundayStatus = value;
    update();
  }

  // monday : -
  String mondayId = '';

  String mondayFromHour = 'Am 10:00';
  String mondayToHour = 'PM 05:00';
  bool mondayStatus = false;

  void getMondayFromHour(String fromHour) {
    mondayFromHour = fromHour;
    update();
  }

  void getMondayToHour(String toHour) {
    mondayToHour = toHour;
    update();
  }

  void getMondayStatus(bool value) {
    mondayStatus = value;
    update();
  }

  // tuesday : -
  String tuesdayId = '';

  String tuesdayFromHour = 'Am 10:00';
  String tuesdayToHour = 'PM 05:00';
  bool tuesdayStatus = false;

  void getTuesdayFromHour(String fromHour) {
    tuesdayFromHour = fromHour;
    update();
  }

  void getTuesdayToHour(String toHour) {
    tuesdayToHour = toHour;
    update();
  }

  void getTuesdayStatus(bool value) {
    tuesdayStatus = value;
    update();
  }

  // wednesday : -
  String wednesdayId = '';

  String wednesdayFromHour = 'Am 10:00';
  String wednesdayToHour = 'PM 05:00';
  bool wednesdayStatus = false;

  void getWednesdayFromHour(String fromHour) {
    wednesdayFromHour = fromHour;
    update();
  }

  void getWednesdayToHour(String toHour) {
    wednesdayToHour = toHour;
    update();
  }

  void getWednesdayStatus(bool value) {
    wednesdayStatus = value;
    update();
  }

  // thursday : -
  String thursdayId = '';

  String thursdayFromHour = 'Am 10:00';
  String thursdayToHour = 'PM 05:00';
  bool thursdayStatus = false;

  void getThursdayFromHour(String fromHour) {
    thursdayFromHour = fromHour;
    update();
  }

  void getThursdayToHour(String toHour) {
    thursdayToHour = toHour;
    update();
  }

  void geThursdayStatus(bool value) {
    thursdayStatus = value;
    update();
  }

  // friday : -
  String fridayId = '';

  String fridayFromHour = 'Am 10:00';
  String fridayToHour = 'PM 05:00';
  bool fridayStatus = false;

  void getFridayFromHour(String fromHour) {
    fridayFromHour = fromHour;
    update();
  }

  void getFridayToHour(String toHour) {
    fridayToHour = toHour;
    update();
  }

  void getFridayStatus(bool value) {
    fridayStatus = value;
    update();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: currentTabbrIndex);
    nameCtrl = TextEditingController(text: MySharedPreferences.fName);
    emailCtrl = TextEditingController(text: MySharedPreferences.email);
    addressCtrl = TextEditingController(text: MySharedPreferences.address);
    phoneNumberCtrl = TextEditingController(
      text: MySharedPreferences.userNumber
          .toString()
          .split(MySharedPreferences.countryCode)
          .join()
          .substring(
              0,
              MySharedPreferences.userNumber
                      .toString()
                      .split(MySharedPreferences.countryCode)
                      .join()
                      .length -
                  1),
    );
    newPasswordCtrl = TextEditingController();
    currentPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneNumberCtrl.dispose();
    newPasswordCtrl.dispose();
    addressCtrl.dispose();
    currentPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }

  ClinicModel? clinicModel;
  Future updateCommunication({
    required double lat,
    required double long,
    required String address,
    // required String phone,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    clinicModel = await UpdateCommunicationForClinicApi.data(
      lat: lat,
      long: long,
      address: address,
      // phone: phone,
    );
    if (clinicModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (clinicModel!.code == 200) {
      MySharedPreferences.address = clinicModel!.data!.address.toString();
      MySharedPreferences.userNumber = clinicModel!.data!.phone.toString();

      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (clinicModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: clinicModel!.msg!);
    }
    Loader.hide();
  }

  Future updatePassword({
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    clinicModel = await UpdatePasswordForClinicApi.data(password: password);
    if (clinicModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (clinicModel!.code == 200) {
      MySharedPreferences.password = password;
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (clinicModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: clinicModel!.msg!);
    }
    Loader.hide();
  }

  Future updateInformation({
    required String userName,
    required String email,
    required String phone,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    clinicModel = await UpdateInformationForClinicApi.data(
        userName: userName, email: email, phone: phone);
    if (clinicModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (clinicModel!.code == 200) {
      // MySharedPreferences.email = clinicModel!.data!.email.toString();
      MySharedPreferences.userNumber = clinicModel!.data!.phone.toString();
      MySharedPreferences.fName = clinicModel!.data!.name.toString();

      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (clinicModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: clinicModel!.msg!);
    }
    Loader.hide();
  }
}
