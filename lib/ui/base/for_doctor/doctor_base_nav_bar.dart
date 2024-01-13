import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/map.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/my_app_drawer.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/plans_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorBaseNavBar extends StatefulWidget {
  const DoctorBaseNavBar({super.key});
  @override
  State<DoctorBaseNavBar> createState() => _DoctorBaseNavBarState();
}

class _DoctorBaseNavBarState extends State<DoctorBaseNavBar> {
  @override
  void initState() {
    MySharedPreferences.lastScreen='DoctorBaseNavBar';
    Get.put(UserLocationCtrl(), permanent: true);
    Get.put(MapController(), permanent: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // print(DateTime.now().toString().split(' ').first);
    return GetBuilder<DoctorBaseNavBarCtrl>(
      builder: (ctrl) {
        if (ctrl.isPaymentActive == 1) {
          if (MySharedPreferences.isSubscriped) {
            return ZoomDrawer(
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
                backgroundColor: Colors.white,
                controller: ctrl.navBarController,
                context,
                screens: ctrl.buildScreens(),
                hideNavigationBar: false,
                confineInSafeArea: true,
                items: ctrl.navBarsItems(),
                handleAndroidBackButtonPress: true, // Default is true.
                resizeToAvoidBottomInset:
                    true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                stateManagement: true, // Default is true.
                hideNavigationBarWhenKeyboardShows:
                    true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                decoration: const NavBarDecoration(
                  colorBehindNavBar: Colors.white,
                ),
                popAllScreensOnTapOfSelectedTab: true,
                popActionScreens: PopActionScreensType.all,
                itemAnimationProperties: const ItemAnimationProperties(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                ),
                screenTransitionAnimation: const ScreenTransitionAnimation(
                  animateTabTransition: true,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 200),
                ),
                navBarStyle: NavBarStyle.style1,
              ),
            );
          }
          if (!MySharedPreferences.isSubscriped) {
            return const PlansScreen();
          } else {
            return Container();
          }
        }
        if (ctrl.isPaymentActive == 0) {
          return ZoomDrawer(
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
              backgroundColor: Colors.white,
              controller: ctrl.navBarController,
              context,
              screens: ctrl.buildScreens(),
              hideNavigationBar: false,
              confineInSafeArea: true,
              items: ctrl.navBarsItems(),
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset:
                  true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows:
                  true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: const NavBarDecoration(
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style1,
            ),
          );
        } else {
          return const Scaffold(
            body: LoadingIndicator(),
          );
        }
      },
    );
  }
}
