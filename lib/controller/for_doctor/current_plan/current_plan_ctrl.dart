import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/for_doctor/current_plan/current_plan_api.dart';
import 'package:way_to_doctor_doctor/model/subscription_model/subscription_model.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CurrentPlanCtrl extends GetxController {
  static CurrentPlanCtrl get find => Get.find();

  SubscriptionModel? subscriptionModel;
  late Future<SubscriptionModel?> initializeCurrentPlanFuture;

  initCurrentPlan() {
    initializeCurrentPlanFuture = fetchCurrentPlan();
  }

  Future<SubscriptionModel?> fetchCurrentPlan() async {
    print( 'MySharedPreferences.subscriptionId ${MySharedPreferences.subscriptionId}');
    subscriptionModel = await CurrentPlanApi.getCurrentplan(
        subId: MySharedPreferences.subscriptionId);

    if (subscriptionModel!.code == 200) {
      return subscriptionModel;
    }
    return null;
  }

  @override
  void onInit() {
    initCurrentPlan();
    super.onInit();
  }
}
