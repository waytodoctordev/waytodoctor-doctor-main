// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';

import '../../../model/categories/add_doctor_to_category_model.dart';
import '../../../model/categories/categories_model.dart';
import '../../../api/for_doctor/doctor_details/network_categories_api.dart';
import '../../../ui/widgets/overlay_loader.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/shared_prefrences.dart';

class NetworkCategoriesCtrl extends GetxController {
  static NetworkCategoriesCtrl get find => Get.find();
  DoctorDetailsModel? doctorsModel;
  bool loaded = false;
  CategoriesModel? categoriesModel;
  late Future<CategoriesModel?> initializeNetworkCategoriesFuture;

  Future<CategoriesModel?> fetchNetworkCategories() async {
    categoriesModel = await NetworkCategoriesApi.data();
    return categoriesModel;
  }

  void initCategoriesFuture() {
    initializeNetworkCategoriesFuture = fetchNetworkCategories();
    super.onInit();
  }

  @override
  void onInit() {
    initCategoriesFuture();
    super.onInit();
  }

  AddCategoryModel? addCategoryModel;
  Future addCategoryToDoctor({
    required String catId,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    addCategoryModel =
        await NetworkCategoriesApi.addDoctorToCategory(catId: catId);
    if (addCategoryModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (addCategoryModel!.code == 200) {
      MySharedPreferences.categoryId = int.parse(catId);
      Get.back();
      DoctorDetailsCtrl.find.init();
      AppConstants()
          .showMsgToast(context, msg: AppConstants.updatedSuccessfully);
    } else if (addCategoryModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: addCategoryModel!.msg);
    }
    Loader.hide();
  }
}
