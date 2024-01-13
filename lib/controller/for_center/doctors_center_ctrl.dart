import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import '../../api/for_center/change_activity_status_api.dart';
import '../../api/for_center/doctors_center_api.dart';
import '../../model/home_screen/doctors_model.dart';
import '../../model/main_model.dart';
import '../../ui/widgets/overlay_loader.dart';
import '../../utils/app_constants.dart';
import '../../utils/shared_prefrences.dart';


class DoctorsCenterCtrl extends GetxController {
  static DoctorsCenterCtrl get find => Get.find();

  CentersModel? doctorsCentersModel;
   Future<CentersModel?>? initializeDoctorCenterFuture;

  Future<CentersModel?> fetchDoctorCenterData(
      {required int categoryId,
        required String search,
        required int centerId}) async {
    doctorsCentersModel = await DoctorsCenterApi.data(
        categoryId: categoryId,
        centerId: centerId,
        search: search);
    update();
    return doctorsCentersModel;

  }

  init({required int categoryId,required String search,required int centerId}) {
    initializeDoctorCenterFuture = fetchDoctorCenterData(categoryId:categoryId,centerId: centerId,search: search);
    update();
  }
  MainModel? changeActivityStatus;
  Future changeActivityStatusRequest({
    required String doctorId,
    required bool centerStatus,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context,);
    changeActivityStatus =
    await   ChangeActivityStatusApi.request(
      doctorId: doctorId,
      activityStatus: centerStatus,
    );
    if (changeActivityStatus == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (changeActivityStatus!.status == true) {
      Loader.hide();
     await  init(
          categoryId: int.parse(MySharedPreferences.centerCategoryID),
         search:'',
         centerId:MySharedPreferences.centerID);
      Get.snackbar("Success".tr, changeActivityStatus!.msg!);
      // AppConstants().showMsgToast(context, msg:changeActivityStatus!.msg.toString() );

    } else if (changeActivityStatus!.code == 500) {
      AppConstants().showMsgToast(context, msg: changeActivityStatus!.msg.toString());
    } else {
      AppConstants().showMsgToast(context, msg: changeActivityStatus!.msg.toString());
    }

    Loader.hide();
  }
}
