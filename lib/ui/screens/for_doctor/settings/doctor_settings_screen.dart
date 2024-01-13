import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/settings/settings_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/account_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/communications_components.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/components/working_hours_component/working_hours_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/widgets/settings_tabbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/settings/widgets/doctor_appbar.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorSettingsScreen extends StatefulWidget {
  const DoctorSettingsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorSettingsScreen> createState() => _DoctorSettingsScreenState();
}

class _DoctorSettingsScreenState extends State<DoctorSettingsScreen> {
  @override
  void initState() {
    Get.put(SettingsCtrl());
    SettingsCtrl.find.initWorkHours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SettingsCtrl>(
        builder: (controller) => SafeArea(
            child: Column(
          children: [
            const DoctorSettingsAppbar(),
            const DoctorSettingsTabbar(),
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
                    WorkingHoursComponents(),
                    CommunicationsComponents(),
                    AccountComponent(),
                  ],
                ),
              ),
            ),
            GetBuilder<SettingsCtrl>(
              builder: (controller) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 10),
                child: CustomElevatedButton(
                  title: 'Save'.tr,
                  width: double.maxFinite,
                  onPressed: () async {
                    if (controller.currentTabbrIndex == 0) {
                      if (controller.workHours!.length != 7) {
                      } else {
                        // saturday : -
                         controller.updateWorkHours(
                          dayId: controller.saturdayId,
                          from: controller.saturdayFromHour,
                          to: controller.saturdayToHour,
                          status:
                              controller.saturdayStatus == false ? '0' : '1',
                          context: context,
                        );
                        // sunday : -
                         controller.updateWorkHours(
                          dayId: controller.sundayId,
                          from: controller.sundayFromHour,
                          to: controller.sundayToHour,
                          status: controller.sundayStatus == false ? '0' : '1',
                          context: context,
                        );
                        // monday : -
                         controller.updateWorkHours(
                          dayId: controller.mondayId,
                          from: controller.mondayFromHour,
                          to: controller.mondayToHour,
                          status: controller.mondayStatus == false ? '0' : '1',
                          context: context,
                        );
                        // tuesday : -
                         controller.updateWorkHours(
                          dayId: controller.tuesdayId,
                          from: controller.tuesdayFromHour,
                          to: controller.tuesdayToHour,
                          status: controller.tuesdayStatus == false ? '0' : '1',
                          context: context,
                        );
                        // wednesday : -
                         controller.updateWorkHours(
                          dayId: controller.wednesdayId,
                          from: controller.wednesdayFromHour,
                          to: controller.wednesdayToHour,
                          status:
                              controller.wednesdayStatus == false ? '0' : '1',
                          context: context,
                        );
                        // thursday : -
                         controller.updateWorkHours(
                          dayId: controller.thursdayId,
                          from: controller.thursdayFromHour,
                          to: controller.thursdayToHour,
                          status:
                              controller.thursdayStatus == false ? '0' : '1',
                          context: context,
                        );
                        // friday : -
                         controller.updateWorkHours(
                          dayId: controller.fridayId,
                          from: controller.fridayFromHour,
                          to: controller.fridayToHour,
                          status: controller.fridayStatus == false ? '0' : '1',
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
                          phone: controller.phoneNumberCtrl.text,
                          context: context,
                        );
                      }
                    } else if (controller.currentTabbrIndex == 2) {
                      if (controller.clinicUserNameFormKey.currentState!
                          .validate()) {
                        // print(MySharedPreferences.userId);
                        controller.updateClinicPasswordByDoctor(
                          password: controller.clinicPasswordAgianCtrl.text,
                          context: context,
                        );
                      }
                    }
                  },
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
