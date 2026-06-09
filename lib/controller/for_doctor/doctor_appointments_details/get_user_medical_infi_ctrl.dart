import 'dart:developer';

import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/user_medical_info_model/user_medical_info_model.dart';

import '../../../api/for_doctor/appointments_details/get_user_medical_info_api.dart';

class UserMedicalCtrl extends GetxController {
  static UserMedicalCtrl get find => Get.find();

  MedicalInfoModel? medicalInfoModel;

  late Future<MedicalInfoModel?> initializeMedicalInfoFuture;
  Future<MedicalInfoModel?> fetchMedicalInfo(String userId) async {
    medicalInfoModel = await UserMedicalInfiApi.data(userId: userId);
    log(medicalInfoModel!.data[0].section);
    for (var section in medicalInfoModel!.data) {
      tabBarItems.addIf(
          !tabBarItems.contains(section.section), section.section);
    }

    return medicalInfoModel;
  }

  initMedicalInfo(String userId) {
    initializeMedicalInfoFuture = fetchMedicalInfo(userId);
  }

  List<String> tabBarItems = [];
}
