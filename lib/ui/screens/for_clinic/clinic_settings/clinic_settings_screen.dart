import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/binding/registration/registration_binding.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/settings/clinic_settings_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_settings/components/account_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_settings/components/communications_components.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_settings/widgets/clinic_settings_appbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_settings/widgets/clinic_settings_tabbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../api/logout/logout_api.dart';
import 'components/clinic_working_hours_component/working_hours_component.dart';

class ClinicSettingsScreen extends StatefulWidget {
  const ClinicSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ClinicSettingsScreen> createState() => _ClinicSettingsScreenState();
}

class _ClinicSettingsScreenState extends State<ClinicSettingsScreen> {
  @override
  void initState() {
    Get.put(ClinicSettingsCtrl());
    ClinicSettingsCtrl.find.initWorkHours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(
    //   MySharedPreferences.userNumber
    //       .toString()
    //       .split(MySharedPreferences.countryCode)
    //       .join()
    //       .substring(
    //           0,
    //           MySharedPreferences.userNumber
    //                   .toString()
    //                   .split(MySharedPreferences.countryCode)
    //                   .join()
    //                   .length -
    //               1),
    // );
    return Scaffold(
      body: GetBuilder<ClinicSettingsCtrl>(
        builder: (controller) => SafeArea(
            child: Column(
          children: [
            const ClinicSettingsAppbar(),
            const ClinicSettingsTabbar(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: PageView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: controller.pageController,
                  onPageChanged: (value) {
                    controller.getCurrentTabbarIndex(value);
                  },
                  children: const [
                    ClinicWorkingHoursComponents(),
                    ClinicCommunicationsComponents(),
                    ClinicAccountComponent(),
                  ],
                ),
              ),
            ),
            GetBuilder<ClinicSettingsCtrl>(
              builder: (controller) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 10),
                child: controller.currentTabbrIndex != 2
                    ? CustomElevatedButton(
                        title: 'Save'.tr,
                        width: double.maxFinite,
                        onPressed: () async {

                          if (controller.currentTabbrIndex == 0) {
                            if (controller.workHours!.length != 7) {
                            } else {
                              controller.showLoader.value=true;
                              // saturday : -
                              await controller.updateWorkHours(
                                dayId: controller.saturdayId,
                                from: controller.saturdayFromHour,
                                to: controller.saturdayToHour,
                                status: controller.saturdayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                              // sunday : -
                              await controller.updateWorkHours(
                                dayId: controller.sundayId,
                                from: controller.sundayFromHour,
                                to: controller.sundayToHour,
                                status: controller.sundayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                              // monday : -
                              await controller.updateWorkHours(
                                dayId: controller.mondayId,
                                from: controller.mondayFromHour,
                                to: controller.mondayToHour,
                                status: controller.mondayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                              // tuesday : -
                              await controller.updateWorkHours(
                                dayId: controller.tuesdayId,
                                from: controller.tuesdayFromHour,
                                to: controller.tuesdayToHour,
                                status: controller.tuesdayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                              // wednesday : -
                              await controller.updateWorkHours(
                                dayId: controller.wednesdayId,
                                from: controller.wednesdayFromHour,
                                to: controller.wednesdayToHour,
                                status: controller.wednesdayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                              // thursday : -
                              await controller.updateWorkHours(
                                dayId: controller.thursdayId,
                                from: controller.thursdayFromHour,
                                to: controller.thursdayToHour,
                                status: controller.thursdayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                              controller.showLoader.value=false;
                              // friday : -
                              await controller.updateWorkHours(
                                dayId: controller.fridayId,
                                from: controller.fridayFromHour,
                                to: controller.fridayToHour,
                                status: controller.fridayStatus == false
                                    ? '0'
                                    : '1',
                                context: context,
                              );
                            }
                          } else if (controller.currentTabbrIndex == 1) {
                            if (controller.communicationFormKey.currentState!
                                .validate()) {
                              controller.updateCommunication(
                                lat: MySharedPreferences.lat,
                                long: MySharedPreferences.long,
                                address: controller.addressCtrl.text,
                                // phone: controller.phoneNumberCtrl.text,
                                context: context,
                              );
                            }
                          }
                          // else if (controller.currentTabbrIndex == 2) {
                          //   if (controller.currentPage == 0) {
                          //     if (controller.personalFormKey.currentState!.validate()) {
                          //       controller.updateInformation(userName: controller.nameCtrl.text, email: controller.emailCtrl.text, phone: controller.phoneNumberCtrl.text, context: context);
                          //     }
                          //   } else {
                          //     if (controller.passwordFormKey.currentState!.validate()) {
                          //       // controller.updatePassword(password: controller.newPasswordCtrl.text, context: context);
                          //     }
                          //   }
                          // }
                        },
                      )
                    : OutlinedButton(
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
                              side: const BorderSide(
                                  width: 10, color: MyColors.red),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text(
                          'Sign out'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            color: MyColors.red101,
                          ),
                        ),
                      ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
