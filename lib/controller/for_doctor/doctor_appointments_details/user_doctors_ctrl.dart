// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/appointments_details/get_user_doctors_api.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/doctors_model.dart';
import 'package:way_to_doctor_doctor/model/user_other_doctors/user_other_doctors_model.dart';

import '../../../api/for_doctor/appointments_details/user_other_doctors_api.dart';

class UserDoctorsCtrl extends GetxController {
  static UserDoctorsCtrl get find => Get.find();

  int currentIndex = 0;
  List<String> titles = ['Medical network'.tr, 'Others'.tr];
  void getCurrentIndex(index) {
    currentIndex = index;
    update();
  }

  late PagingController<int, Doctors> pagingController;
  String? userId;
  Future<void> fetchPage(int pageKey, String userId) async {
    try {
      final model = await MydoctorsApi.data(pageKey: pageKey, userId: userId);
      final newItems = model!.data;

      if (newItems!.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  late PagingController<int, OtherDoctorsData> otherDoctorsPagingController;

  Future<void> fetchOtherDoctors(int pageKey, String userId) async {
    try {
      final model = await GetOtherDoctorsApi.myOtherDoctors(
          pageKey: pageKey, userId: userId);
      final newItems = model!.data;

      if (newItems.isEmpty) {
        otherDoctorsPagingController.appendLastPage(newItems);
      } else {
        otherDoctorsPagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      otherDoctorsPagingController.error = error;
    }
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey, userId!);
      });

    otherDoctorsPagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchOtherDoctors(pageKey, userId!);
      });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
