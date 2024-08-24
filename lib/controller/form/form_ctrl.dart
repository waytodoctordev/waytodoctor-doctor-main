// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart' ;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_clinic/clinic_settings/update_clinic_address_api.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/settings/update_doctor_address_api.dart';
import 'package:way_to_doctor_doctor/api/registration/cities_api.dart';
import 'package:way_to_doctor_doctor/api/registration/countries_api.dart';
import 'package:way_to_doctor_doctor/api/registration/update_form_information_api.dart';
import 'package:way_to_doctor_doctor/model/clinic_model/clinic_model.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/model/registration/cities_model.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../registration/specialization_ctrl.dart';

class FormCtrl extends GetxController {
  static FormCtrl get find => Get.find();
  late PageController formPageCtrl;
  var formPageIndicatorCtrl = CarouselSliderController();

  late TextEditingController firstNameCtrl;
  late TextEditingController secondNameCtrl;
  late TextEditingController thirdNameCtrl;
  late TextEditingController familyNameCtrl;
  late TextEditingController nationalIdCtrl;
  late TextEditingController dayCtrl;
  late TextEditingController monthCtrl;
  late TextEditingController yearCtrl;
  late TextEditingController addressCtrl;
  final GlobalKey<FormState> formKey = GlobalKey();

  List<String> genders = [
    'Male'.tr,
    'Female'.tr,
  ];
  String genderDropdownvalue =
      MySharedPreferences.gender == '' ? 'Male'.tr : MySharedPreferences.gender.capitalize.toString().tr; // save local this value NOT to update to api

  List<String> gendersEnglishToSendToApi = [
    'Male',
    'Female',
  ];
  String genderDropdownvalueEnglish = MySharedPreferences.gender == '' ? 'Male' : MySharedPreferences.gender.capitalize.toString(); // update with this value

  List<String> maritalStatusList = [
    'Single'.tr,
    'Married'.tr,
    'Widower'.tr,
    'Divorced'.tr,
  ];
  List<String> maritalStatusEnglishToSendToApi = [
    'Single',
    'Married',
    'Widower',
    'Divorced',
  ];
  String maritalStatusValue = MySharedPreferences.status == '' ? 'Single'.tr : MySharedPreferences.status.capitalize.toString().tr;
  String maritalStatusValueEngish = MySharedPreferences.status == '' ? 'Single' : MySharedPreferences.status.capitalize.toString();
// single','engaged','married','devorced','widowed
  setGender(String gender) {
    int index = genders.indexOf(gender);
    genderDropdownvalue = gender;
    genderDropdownvalueEnglish = gendersEnglishToSendToApi[index];
    update();
  }

  setMaritalStatus(String maritalStatus) {
    int index = maritalStatusList.indexOf(maritalStatus);
    maritalStatusValue = maritalStatus;
    maritalStatusValueEngish = maritalStatusEnglishToSendToApi[index];
    update();
  }

  File image = File('');
  final RxString profileImage = ''.obs;
  RxBool isImageAdded = false.obs;

  getFile(context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(
        result.files.single.path.toString(),
      );
      image = file;
      profileImage.value = image.path;
      isImageAdded.value = true;
      MySharedPreferences.profileImage = image;
      MySharedPreferences.userImage = image.path; //profileImage.value;
      update();
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
    }
  }

  Future<bool> editProfileImage({
    context,
    required String name,
    required File professionalLicense,
    required String phone,
    required String address,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(
        result.files.single.path.toString(),
      );
      image = file;
      profileImage.value = image.path;
      isImageAdded.value = true;
      MySharedPreferences.profileImage = image;
      MySharedPreferences.userImage = image.path; //profileImage.value;
      SpecializationCtrl.find.professionalLicenseRequest(
          context: context, name: name, phone: phone, imageProfile: image, address: address, professionalLicense: professionalLicense, isEditCenterInfo: true);
      update();
      return true;
    } else {
      AppConstants().showMsgToast(context, msg: 'No file selected'.tr);
      return false;
    }
  }

  @override
  void onClose() {
    firstNameCtrl.dispose();
    secondNameCtrl.dispose();
    thirdNameCtrl.dispose();
    familyNameCtrl.dispose();
    nationalIdCtrl.dispose();
    dayCtrl.dispose();
    monthCtrl.dispose();
    yearCtrl.dispose();
    // addressCtrl.dispose();
    formPageCtrl.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    formPageCtrl = PageController(initialPage: MySharedPreferences.formCurrentIndex);
    firstNameCtrl = TextEditingController(text: MySharedPreferences.fName.isEmpty ? '' : MySharedPreferences.fName);
    secondNameCtrl = TextEditingController(text: MySharedPreferences.sName.isEmpty ? '' : MySharedPreferences.sName);
    thirdNameCtrl = TextEditingController(text: MySharedPreferences.tName.isEmpty ? '' : MySharedPreferences.tName);
    familyNameCtrl = TextEditingController(text: MySharedPreferences.lName.isEmpty ? '' : MySharedPreferences.lName);
    nationalIdCtrl = TextEditingController(text: MySharedPreferences.nationalId.isEmpty ? '' : MySharedPreferences.nationalId);
    dayCtrl = TextEditingController(text: MySharedPreferences.dateOfBirth.isEmpty ? '' : MySharedPreferences.dateOfBirth.split('-')[2]);
    monthCtrl = TextEditingController(text: MySharedPreferences.dateOfBirth.isEmpty ? '' : MySharedPreferences.dateOfBirth.split('-')[1]);
    yearCtrl = TextEditingController(text: MySharedPreferences.dateOfBirth.isEmpty ? '' : MySharedPreferences.dateOfBirth.split('-')[0]);
    addressCtrl = TextEditingController(text: MySharedPreferences.address.isEmpty ? '' : MySharedPreferences.address);
    getCountriesList();
    super.onInit();
  }

  UserModel? userModel;

  Future updateUserData({required Map dataBody, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    userModel = await UpdateUserDataApi().updateData(
      dataBody: dataBody,
    );
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      if (MySharedPreferences.formCurrentIndex == 0) {
        // print('new Id :: ${userModel!.user!.id!}');
        MySharedPreferences.userId = userModel!.user!.id!;
        MySharedPreferences.fName = userModel!.user!.name.toString();
        MySharedPreferences.sName = userModel!.user!.secondName.toString();
        MySharedPreferences.tName = userModel!.user!.thirdName.toString();
        MySharedPreferences.lName = userModel!.user!.lastName.toString();
      }
      if (MySharedPreferences.formCurrentIndex == 1) {
        MySharedPreferences.nationalId = userModel!.user!.nationalId.toString();
      }
      if (MySharedPreferences.formCurrentIndex == 2) {
        MySharedPreferences.dateOfBirth = userModel!.user!.dateOfBirth.toString();
      }
      if (MySharedPreferences.formCurrentIndex == 3) {
        MySharedPreferences.gender = userModel!.user!.gender.toString();
      }
      if (MySharedPreferences.formCurrentIndex == 4) {
        MySharedPreferences.status = userModel!.user!.status.toString();
      }
      if (MySharedPreferences.formCurrentIndex == 5) {
        MySharedPreferences.country = userModel!.user!.nationality.toString();
        MySharedPreferences.city = userModel!.user!.country.toString();
        MySharedPreferences.address = userModel!.user!.city.toString();
      }

      try {
        formPageIndicatorCtrl.animateToPage(MySharedPreferences.formIndicatorCurrentIndex + 1);
        MySharedPreferences.formCurrentIndex++;
        MySharedPreferences.formIndicatorCurrentIndex++;
      } on Exception catch (e) {
        log(e.toString());
      }
      update();
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }

  String currentCountry = MySharedPreferences.country == '' ? '' : MySharedPreferences.country;
  String currentCity = MySharedPreferences.city == '' ? '' : MySharedPreferences.city;

  void getCurrentCountry(String country) {
    currentCountry = country;
    update();
  }

  void getCurrentCity(String city) {
    currentCity = city;
    update();
  }

  List<City>? cities;
  CitiesModel? citiesModel;
  List<Country>? countries;
  List<String> countriesNames = [];
  List<int> countriesIds = [];
  List<String> citiesNames = [];
  CountriesModel? countriesModel;

  Future getCountriesList() async {
    countriesModel = await CountryListApi.data();
    if (countriesModel == null) {
      Loader.hide();
      return;
    }
    if (countriesModel!.code == 200) {
      countries = countriesModel!.countries;

      if (countries != null) {
        for (var country in countries!) {
          countriesNames.add(country.name.toString());
          countriesIds.add(int.parse(country.id.toString()));
        }
      }

      // MySharedPreferences.country = currentCountry;
      if (MySharedPreferences.country == '') {
        currentCountry = countries![0].name.toString();

        getcitiesList(countryId: countries![0].id.toString());
      } else {
        int countryIndex = countriesNames.indexOf(MySharedPreferences.country);
        int currentCountryId = countriesIds.elementAt(countryIndex);

        getcitiesList(countryId: currentCountryId.toString());
      }

      update();
    } else if (countriesModel!.code == 500) {
    } else {}
    Loader.hide();
  }

  Future getcitiesList({required String countryId}) async {
    citiesModel = await CitiesListApi.data(countryId: countryId);
    if (citiesModel == null) {
      Loader.hide();
      return;
    }
    if (citiesModel!.code == 200) {
      cities = citiesModel!.cities;
      for (var city in cities!) {
        citiesNames.add(city.name.toString());
      }
      if (MySharedPreferences.city == '') {
        currentCity = cities!.isNotEmpty ? cities![0].name.toString() : 'لا يوجد مدينة';
      } else {
        int currentCityIndex = citiesNames.indexOf(MySharedPreferences.city);
        currentCity = cities!.isNotEmpty ? cities![currentCityIndex].name.toString() : 'لا يوجد مدينة';
      }

      // MySharedPreferences.city = currentCity;
      update();
    } else if (citiesModel!.code == 500) {
    } else {}
    Loader.hide();
  }

  DoctorDetailsModel? doctorDetailsModel;
  Future updateDoctorAddress({
    required double lat,
    required double long,
    required String address,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel = await UpdateAddressForDoctorApi.address(
      lat: lat,
      long: long,
      address: address,
    );
    if (doctorDetailsModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (doctorDetailsModel!.code == 200) {
      MySharedPreferences.address = doctorDetailsModel!.data!.address.toString();
    } else if (doctorDetailsModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: doctorDetailsModel!.msg!);
    }
    Loader.hide();
  }

  ClinicModel? clinicModel;
  Future updateClinicAddress({
    required double lat,
    required double long,
    required String address,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    clinicModel = await UpdateAddressForClinicApi.address(
      lat: lat,
      long: long,
      address: address,
    );
    if (clinicModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (clinicModel!.code == 200) {
      MySharedPreferences.address = clinicModel!.data!.address.toString();
    } else if (clinicModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: clinicModel!.msg!);
    }
    Loader.hide();
  }

  Future updateUserImage({required File profileImage, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    userModel = await UpdateUserDataApi.updateUserImage(
      profileImage: profileImage,
    );
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      if (MySharedPreferences.isDoctor) {
        await updateDoctorImage(profileImage: profileImage, context: context);
      }
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }

  Future updateDoctorImage({required File profileImage, required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    doctorDetailsModel = await UpdateUserDataApi.updateDoctorImage(
      profileImage: profileImage,
    );
    if (userModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (userModel!.code == 200) {
      MySharedPreferences.userImage = userModel!.user!.image.toString();
      await updateUserData(dataBody: {'step': '4'}, context: context); // payment passed step 1
      update();
    } else if (userModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: userModel!.msg!);
    }
    Loader.hide();
  }
}
