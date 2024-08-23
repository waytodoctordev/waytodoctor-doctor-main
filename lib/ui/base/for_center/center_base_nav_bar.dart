import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/map.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';

import '../../../api/logout/logout_api.dart';
import '../../../binding/registration/registration_binding.dart';
import '../../../utils/colors.dart';
import '../../../utils/shared_prefrences.dart';
import '../../screens/registration/registration/registration_screen.dart';
import '../../widgets/loading_indicator.dart';

class CenterBaseNavBar extends StatefulWidget {
  const CenterBaseNavBar({super.key});

  @override
  State<CenterBaseNavBar> createState() => _CenterBaseNavBarState();
}

class _CenterBaseNavBarState extends State<CenterBaseNavBar> {
  @override
  void initState() {
    Get.put(UserLocationCtrl(), permanent: true);
    Get.put(MapController(), permanent: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicBaseNavBarCtrl>(
      builder: (ctrl) {
        if (ctrl.isPaymentActive == 1) {
          if (MySharedPreferences.isSubscriped) {
            return PersistentTabView(
              backgroundColor: Colors.white,
              controller: ctrl.navBarController,
              context,
              screens: ctrl.buildScreens(),
              // hideNavigationBar: false,
              // confineInSafeArea: true,
              items: ctrl.navBarsItems(),
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              // hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: const NavBarDecoration(
                colorBehindNavBar: Colors.white,
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
              navBarStyle: NavBarStyle.style1,
            );
          }
          if (!MySharedPreferences.isSubscriped) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sorry, you cannot use the application until the doctor renews the subscription.'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: MyColors.blue14B,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        Logout().logout();
                        MySharedPreferences.clearProfile();
                        Get.deleteAll(force: true);
                        Get.offAll(
                          () => const RegistrationScreen(),
                          binding: RegestirationBinding(),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            side: const BorderSide(width: 10, color: MyColors.red),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text(
                        'Sign out'.tr,
                        style: const TextStyle(
                          fontSize: 14,
                          color: MyColors.red101,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }
        if (ctrl.isPaymentActive == 0) {
          return PersistentTabView(
            backgroundColor: Colors.white,
            controller: ctrl.navBarController,
            context,
            screens: ctrl.buildScreens(),
            // hideNavigationBar: false,
            // confineInSafeArea: true,
            items: ctrl.navBarsItems(),
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            // hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            // decoration: const NavBarDecoration(
            //   colorBehindNavBar: Colors.white,
            // ),
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
            navBarStyle: NavBarStyle.style1,
          );
        } else {
          return const Scaffold(
            body: LoadingIndicator(),
          );
        }
      },
      // builder: (ctrl) {
      //   return ZoomDrawer(
      //   controller: ctrl.zoomDrawerController,
      //   menuScreen: const MyAppDrawer(),
      //   // mainScreenTapClose: false,
      //   isRtl: MySharedPreferences.language == 'ar' ? true : false,
      //   borderRadius: 24,
      //   style: DrawerStyle.defaultStyle,
      //   slideWidth: size.width / 1.4,
      //   showShadow: true,
      //   androidCloseOnBackTap: true,
      //   shadowLayer1Color: MyColors.blue14B,
      //   shadowLayer2Color: MyColors.blue9D1,
      //   clipMainScreen: false,
      //   duration: const Duration(milliseconds: 650),
      //   // mainScreenOverlayColor: Colors.red,
      //   menuBackgroundColor: MyColors.blue14B,
      //   angle: -0.0,
      //   mainScreenScale: .29,
      //   mainScreen: PersistentTabView(
      //     backgroundColor: Colors.white,
      //     controller: ctrl.navBarController,
      //     context,
      //     screens: ctrl.buildScreens(),
      //     hideNavigationBar: false,
      //     confineInSafeArea: true,
      //     items: ctrl.navBarsItems(),
      //     handleAndroidBackButtonPress: true, // Default is true.
      //     resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      //     stateManagement: true, // Default is true.
      //     hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //     decoration: const NavBarDecoration(
      //       colorBehindNavBar: Colors.white,
      //     ),
      //     popAllScreensOnTapOfSelectedTab: true,
      //     popActionScreens: PopActionScreensType.all,
      //     itemAnimationProperties: const ItemAnimationProperties(
      //       duration: Duration(milliseconds: 200),
      //       curve: Curves.ease,
      //     ),
      //     screenTransitionAnimation: const ScreenTransitionAnimation(
      //       animateTabTransition: true,
      //       curve: Curves.ease,
      //       duration: Duration(milliseconds: 200),
      //     ),
      //     navBarStyle: NavBarStyle.style1,
      //   ),
      // );
      // },
    );
  }
}
