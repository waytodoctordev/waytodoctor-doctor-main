// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_clinic_password_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_communication_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_password_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_personal_into_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_work_hours_for_doctor_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/work_hours_api.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_data_model.dart';
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SettingsCtrl extends GetxController {
  static SettingsCtrl get find => Get.find();
   PageController pageController = PageController();

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

  late TextEditingController nameCtrl;
  late TextEditingController phoneNumberCtrl;
  late TextEditingController addressCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController newPasswordCtrl;
  late TextEditingController currentPasswordCtrl;
  late TextEditingController confirmPasswordCtrl;
  late TextEditingController clinicCtrl;
  late TextEditingController clinicPasswordCtrl;
  late TextEditingController clinicPasswordAgianCtrl;
  final GlobalKey<FormState> personalFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> communicationFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> clinicUserNameFormKey = GlobalKey<FormState>();

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
    if(pageController.hasClients) {
      pageController.animateToPage(value,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  WorkHoursModel? workHoursModel;
  List<WorkHoursData>? workHours;
  late Future<WorkHoursModel?> initializeWorkHoursForDoctor;
  Future<WorkHoursModel?> fetchDoctorWorkHours() async {
    workHoursModel = await WorkHoursForDoctorApi.data();
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

  initWorkHours() {
    initializeWorkHoursForDoctor = fetchDoctorWorkHours();
  }

  WorkHoursDataModel? workHoursDataModel;
  Future updateWorkHours(
      {required String dayId,
      required String from,
      required String to,
      required String status,
      required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    workHoursDataModel = await UpdateWorkHoursForDoctorApi.data(
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
      AppConstants().showMsgToast(context, msg: AppConstants.updatedSuccessfully);

    } else if (workHoursDataModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: workHoursDataModel!.msg!);
    }
    Loader.hide();
  }

  // saturday : -
  String saturdayId = '';
  String saturdayFromHour = '';
  String saturdayToHour = '';
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
  String sundayFromHour = '';
  String sundayToHour = '';
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
  String mondayFromHour = '';
  String mondayToHour = '';
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
  String tuesdayFromHour = '';
  String tuesdayToHour = '';
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
  String wednesdayFromHour = '';
  String wednesdayToHour = '';
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
  String thursdayFromHour = '';
  String thursdayToHour = '';
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
  String fridayFromHour = '';
  String fridayToHour = '';
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
            .join());
    newPasswordCtrl = TextEditingController();
    currentPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    clinicCtrl = TextEditingController();
    clinicPasswordCtrl = TextEditingController();
    clinicPasswordAgianCtrl = TextEditingController();
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
    clinicCtrl.dispose();
    clinicPasswordCtrl.dispose();
    clinicPasswordAgianCtrl.dispose();
    super.onClose();
  }

  DoctorDetailsModel? doctorDetailsModel;
  Future updateCommunication({
    required double lat,
    required double long,
    required String address,
    required String phone,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel = await UpdateCommunicationForDoctorApi.data(
      lat: lat,
      long: long,
      address: address,
      phone: phone,
    );
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      MySharedPreferences.address =
          doctorDetailsModel!.data!.address.toString();
      MySharedPreferences.userNumber =
          doctorDetailsModel!.data!.phone.toString();

      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  UserModel? userModel;
  Future updateDoctorPassword({
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    userModel = await UpdatePasswordApi.data(password: password);
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      MySharedPreferences.password = password;
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
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
    doctorDetailsModel = await UpdateInformationForDoctorApi.data(
        userName: userName, email: email, phone: phone);
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      // MySharedPreferences.email = doctorDetailsModel!.data!.email.toString();
      MySharedPreferences.userNumber =
          doctorDetailsModel!.data!.phone.toString();
      MySharedPreferences.fName = doctorDetailsModel!.data!.name.toString();

      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  Future updateClinicPasswordByDoctor({
    required String password,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    userModel = await UpdateClinicPasswordByDoctorApi.data(password: password);
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      MySharedPreferences.password = password;
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }
}
