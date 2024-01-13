// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:way_to_doctor_doctor/api/plans/plans_api.dart';
import 'package:way_to_doctor_doctor/api/registration/get_step_api.dart';
import 'package:way_to_doctor_doctor/model/plans_model/plans_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/doctor_home_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments/doctor_appointments_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/notifications/doctor_notifications_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/doctor_settings_screen.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../ui/screens/for_center/components/doctor_center_screen.dart';

class DoctorBaseNavBarCtrl extends GetxController {
  static DoctorBaseNavBarCtrl get find => Get.find();

  UserModel? userModel;

  Future getSubscriptionInfo({
    required String token,
  }) async {
    userModel = await GetStepApi.getStepAndQuestion(token: token);
    if (userModel == null) {
      return;
    }
    if (userModel!.code == 200) {
      MySharedPreferences.subscriptionId =
          userModel!.user!.subscriptionId!.toString();
      MySharedPreferences.isSubscriped = userModel!.user!.isSubscriped!;
      update();
    } else if (userModel!.code == 500) {}
  }

  PlansModel? plansModel;
  int? isPaymentActive;
  Future<PlansModel?> fetchPlans() async {
    plansModel = await PlansApi.plans();
    if (plansModel!.code == 200) {
      isPaymentActive = plansModel!.data![0].isActive!;
      update();
      return plansModel;
    }
    return null;
  }

  ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning'.tr;
    } else {
      return 'Good evening'.tr;
    }
  }

  late PersistentTabController navBarController;

  List<Widget> buildScreens() {
    return [
      const DoctorHomeScreen(),
      const DoctorAppointmentsScreen(),
      const DoctorSettingsScreen(),
      const NotificationsScreen(),
    ];
  }
  List<Widget> centerScreens(){
    return [DoctorsCenterScreen(),];
}

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          MyIcons.home,
          height: 20,
          width: 20,
          color: MyColors.blue14B,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          MyIcons.appointments,
          height: 20,
          width: 20,
          color: MyColors.blue14B,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          MyIcons.building,
          height: 20,
          width: 20,
          color: MyColors.blue14B,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          MyIcons.notifications,
          height: 20,
          width: 20,
          color: MyColors.blue14B,
        ),
      ),
    ];
  }

  @override
  void onInit() {
    fetchPlans();
    getSubscriptionInfo(token: MySharedPreferences.accessToken);
    navBarController = PersistentTabController(initialIndex: 0);
    navBarController.addListener(() {
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    navBarController.dispose();
    super.onClose();
  }
}
