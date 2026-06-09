import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/my_app_drawer.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/plans_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../../services/subscriptions/revenueCat_service.dart';
import '../../screens/registration/plans/subscription_screen.dart';
import '../../screens/subscription_details/subscription_screen.dart';

class DoctorBaseNavBar extends StatefulWidget {
  const DoctorBaseNavBar({super.key});
  @override
  State<DoctorBaseNavBar> createState() => _DoctorBaseNavBarState();
}

class _DoctorBaseNavBarState extends State<DoctorBaseNavBar> {
  @override
  void initState() {
    MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
    print('_DoctorBaseNavBarState RevenueCatService.hasSub.value ${RevenueCatService.hasSub.value}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorBaseNavBarCtrl>(
      builder: (ctrl) {
          return !RevenueCatService.hasSub.value?
           ZoomDrawer(
              controller: ctrl.zoomDrawerController,
              menuScreen: const MyAppDrawer(),
              // mainScreenTapClose: false,
              isRtl: MySharedPreferences.language == 'ar' ? true : false,
              borderRadius: 24,
              style: DrawerStyle.defaultStyle,
              slideWidth: Get.width / 1.4,
              showShadow: true,
              androidCloseOnBackTap: true,
              shadowLayer1Color: MyColors.blue14B,
              shadowLayer2Color: MyColors.blue9D1,
              clipMainScreen: false,
              duration: const Duration(milliseconds: 650),
              // mainScreenOverlayColor: Colors.red,
              menuBackgroundColor: MyColors.blue14B,
              angle: -0.0,
              mainScreenScale: .29,
              mainScreen: PersistentTabView(
                decoration: const NavBarDecoration(
                  colorBehindNavBar: Colors.white,
                ),
                context,
                controller: ctrl.navBarController,
                screens: ctrl.buildScreens(),
                items: ctrl.navBarsItems(),
                confineToSafeArea: true,
                handleAndroidBackButtonPress: true, // Default is true.
                resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardAppears: true,
                // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
                backgroundColor: Colors.white,
                isVisible: true,
                animationSettings: const NavBarAnimationSettings(
                  navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  ),
                // popAllScreensOnTapOfSelectedTab: true,
                // popActionScreens: PopActionScreensType.all,
                // itemAnimationProperties: const ItemAnimationProperties(
                //   duration: Duration(milliseconds: 200),
                //   curve: Curves.ease,
                // ),
                // screenTransitionAnimation: const ScreenTransitionAnimation(
                //   animateTabTransition: true,
                //   curve: Curves.ease,
                //   duration: Duration(milliseconds: 200),
                // ),
              ),),
            ):
           SubscriptionScreen();

      },
    );
  }
}
