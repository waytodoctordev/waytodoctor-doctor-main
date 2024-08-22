import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/customer_info_wrapper.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:way_to_doctor_doctor/binding/advantges/advantages_binding.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_details/doctor_details_binding.dart';
import 'package:way_to_doctor_doctor/binding/policy/policy_binding.dart';
import 'package:way_to_doctor_doctor/binding/privcy/privcy_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/binding/terms/terms_binding.dart';
import 'package:way_to_doctor_doctor/binding/who_are_we/who_are_we_binding.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/advantages_screen.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/drawer_appbar.dart';
import 'package:way_to_doctor_doctor/ui/base/policy_screen.dart';
import 'package:way_to_doctor_doctor/ui/base/privcy_screen.dart';
import 'package:way_to_doctor_doctor/ui/base/terms_screen.dart';
import 'package:way_to_doctor_doctor/ui/base/who_are_we_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/Joining_center/joining_center.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/current_plan/current_plan_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/edit_profile_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../api/logout/logout_api.dart';
import '../../screens/for_doctor/direct_call/direct_call_screen.dart';
import '../call_us_screen.dart';
import 'doctor_base_nav_bar.dart';

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue14B,
      body: SafeArea(
          child: GetBuilder<DoctorBaseNavBarCtrl>(
        builder: (controller) => Column(
          children: [
            CustomAppBar(
              color: MyColors.white,
              text: 'Menu'.tr,
              onPressed: () =>
                  controller.zoomDrawerController.toggle!(forceToggle: true),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 50),
                children: [
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () async {
                        CustomerInfo customerInfo =
                            await Purchases.getCustomerInfo();
                        print('customerInfo $customerInfo');
                        final entitlement =
                            customerInfo.entitlements.active.values.first;
                        String currentPlan = entitlement.productIdentifier ==
                                'Premium_Monthly_Subscription'
                            ? 'Monthly Subscription'
                            : 'Annual Subscription';
                        final expirationDate =
                            DateTime.parse(entitlement.expirationDate!);
                        print('expirationDate $expirationDate');
                        final now = DateTime.now();
                        final remainingDays =
                            expirationDate.difference(now).inDays;

                        Get.to(() => CurrentPlanScreen(
                            currentPlan: currentPlan,
                            remainingDays: remainingDays));
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Subscriptions'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),

                  /// JOINING CENTER
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(() => const JoiningCenter());
                      },
                      horizontalTitleGap: 20,
                      title: Text(
                        'Joining To Center'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(() => const DirectCallScreen());
                      },
                      horizontalTitleGap: 20,
                      title: Text(
                        'Direct Call'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(
                            () => const DoctorDetailsScreen(
                                  doctorId: '',
                                ),
                            binding: DoctorDetailsBinding());
                      },
                      horizontalTitleGap: 20,
                      title: Text(
                        'Edit Account'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        // controller.zoomDrawerController.toggle!(forceToggle: true);
                        Get.to(() => const PrivcyScreen(),
                            binding: PrivacyBinding());
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Privacy policy'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(() => const TermsScreen(),
                            binding: Termsinding());

                        // controller.zoomDrawerController.toggle!(forceToggle: true);
                        // Get.to(() => ProfileScreen());
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Terms and Conditions'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(() => const CallUsScreen());
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'contact us'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () => Get.to(() => const PolicyScreen(),
                          binding: PolicyBinding()),
                      horizontalTitleGap: 20,
                      title: Text(
                        'Return policy'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        // controller.zoomDrawerController.toggle!(forceToggle: true);
                        Get.to(() => const AdvantagesScreen(),
                            binding: AdvantagesBinding());
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Advantages and goals'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(() => const WhoWeAreScreen(),
                            binding: WhoAreWeBinding());

                        // controller.zoomDrawerController.toggle!(forceToggle: true);
                        // Get.to(() => ProfileScreen());
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Who are we'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                  ),

                  /// ARABIC LANGUAGE
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () async {
                        MySharedPreferences.language = 'ar';
                        MySharedPreferences.isPassedLanguage = true;
                        Get.updateLocale(Locale(MySharedPreferences.language));
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Arabic'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: MySharedPreferences.language == 'ar'
                              ? MyColors.greenc4e
                              : MyColors.white,
                        ),
                      ),
                    ),
                  ),

                  /// ENGLISH LANGUAGE
                  SizedBox(
                    height: 40,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () async {
                        MySharedPreferences.language = 'en';
                        MySharedPreferences.isPassedLanguage = true;
                        Get.updateLocale(Locale(MySharedPreferences.language));
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'English'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: MySharedPreferences.language == 'en'
                              ? MyColors.greenc4e
                              : MyColors.white,
                        ),
                      ),
                    ),
                  ),

                  /// TURKISH LANGUAGE
                  SizedBox(
                    height: 40,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () async {
                        MySharedPreferences.language = 'tr';
                        MySharedPreferences.isPassedLanguage = true;
                        Get.updateLocale(Locale(MySharedPreferences.language));
                      }, // open new screen
                      horizontalTitleGap: 20,
                      title: Text(
                        'Turkish'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          color: MySharedPreferences.language == 'tr'
                              ? MyColors.greenc4e
                              : MyColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  MySharedPreferences.id != 0
                      ? InkWell(
                          onTap: () {
                            Logout().logout();
                            MySharedPreferences.clearProfile();
                            Get.deleteAll(force: true);
                            Get.offAll(
                              () => const RegistrationScreen(),
                              binding: RegestirationBinding(),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            padding: const EdgeInsetsDirectional.only(
                                start: 30, end: 30),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                MySharedPreferences.language == 'ar'
                                    ? SvgPicture.asset(
                                        MyIcons.signOut,
                                        height: 18,
                                        width: 18,
                                        color: MyColors.white,
                                      )
                                    : RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                            180 / 360),
                                        child: SvgPicture.asset(
                                          MyIcons.signOut,
                                          height: 18,
                                          width: 18,
                                          color: MyColors.white,
                                        ),
                                      ),
                                const SizedBox(width: 10),
                                Text(
                                  'Sign out'.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: MyColors.white,
                                    textBaseline: TextBaseline.alphabetic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 35),
                  Text(
                    'All Rights Reserved To Way To Doctor'.tr,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
