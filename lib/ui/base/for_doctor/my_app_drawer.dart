import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_details/doctor_details_binding.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/registration/sign_in_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/drawer_appbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/Joining_center/joining_center.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/edit_profile_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../binding/privcy/policies_binding.dart';
import '../../screens/for_doctor/direct_call/direct_call_screen.dart';
import '../call_us_screen.dart';
import '../policies_screen.dart';

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
                padding: const EdgeInsets.only(top: 20),
                children: [
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(() => JoiningCenter());
                      },
                      horizontalTitleGap: 10,
                      minVerticalPadding: 10,
                      title: Text(
                        'Center Enrollment'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: MyColors.white,
                        ),
                      ),
                      leading: Icon(
                        Icons.person_add,
                      ),
                    ),
                  ),
                  // DIRECT  CALL
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
                      leading: Icon(
                        Icons.phone_in_talk,
                      ),
                    ),
                  ),
                  //EDIT ACCOUNT
                  SizedBox(
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          const EdgeInsetsDirectional.only(start: 25, end: 25),
                      onTap: () {
                        Get.to(
                            () => DoctorDetailsScreen(
                                  doctorId: MySharedPreferences.id.toString(),
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
                      leading: Icon(Icons.edit),
                    ),
                  ),

                  //CONTACT US
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
                      leading: Icon(Icons.chat_outlined),
                    ),
                  ),
                  /// ARABIC LANGUAGE
                  buttons('Arabic', 'ar'),

                  /// ENGLISH LANGUAGE
                  buttons('English', 'en'),

                  /// TURKISH LANGUAGE
                  buttons('Turkish', 'tr'),

                  //Advantages and goals policy
                  policiesContainer(
                      pageId: '5', policyName: 'Advantages and goals'),
                  //Privacy policy
                  policiesContainer(pageId: '6', policyName: 'Privacy policy'),
                  //Terms and Conditions policy
                  policiesContainer(
                      pageId: '7', policyName: 'Terms and Conditions'),
                 //Return policy policy
                  policiesContainer(pageId: '9', policyName: 'Return policy'),
                  // WHO WE ARE
                  policiesContainer(pageId: '8', policyName: 'Who are we'),

                  SizedBox(height: Get.height * .03),

                  MySharedPreferences.id != 0
                      ? InkWell(
                          onTap: () {
                            SignInCtrl().logout(context: context);
                            MySharedPreferences.clearProfile();
                            Get.deleteAll(force: true);
                            Get.offAll(
                              () => const RegistrationScreen(),
                              binding: RegistrationBinding(),
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
                                  color: Colors.grey,

                                )
                                    : RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                            180 / 360),
                                        child: SvgPicture.asset(
                                          MyIcons.signOut,
                                          height: 18,
                                          width: 18,

                                          color: Colors.grey,
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
                  const SizedBox(height: 30),
                  Container(
                   margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'All Rights Reserved To Way To Doctor'.tr,
                      style: const TextStyle(fontSize: 15, color: Colors.grey),
                      textAlign: TextAlign.center,

                    ),
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

Widget buttons(String name, String langChar,) {
  return SizedBox(
    height: 50,
    child: ListTile(
      contentPadding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      onTap: () async {
        MySharedPreferences.language = langChar;
        MySharedPreferences.isPassedLanguage = true;
        Get.updateLocale(Locale(MySharedPreferences.language));
      }, // open new screen
      horizontalTitleGap: 20,
      title: Text(
        name.tr,
        style: TextStyle(
          fontSize: 16,
          color: MySharedPreferences.language == langChar
              ? MyColors.greenc4e
              : MyColors.white,
        ),
      ),
      trailing: Text(langChar,style: TextStyle(
        fontSize: 16,
        color: MySharedPreferences.language == langChar
            ? MyColors.greenc4e
            : MyColors.white,
      ),),
    ),
  );
}

Widget policiesContainer({required String pageId, required String policyName}) {
  return SizedBox(
    height: 50,
    child: ListTile(
      contentPadding: const EdgeInsetsDirectional.only(start: 25, end: 25),
      onTap: () {
        Get.to(
            () => PoliciesScreen(
                  pageId: pageId,
                  policyName: policyName,
                ),
            binding: PoliciesBinding());
      }, // open new screen
      horizontalTitleGap: 20,
      title: Text(
        policyName.tr,
        style: const TextStyle(
          fontSize: 15,
          color: MyColors.white,
        ),
      ),
    ),
  );
}
