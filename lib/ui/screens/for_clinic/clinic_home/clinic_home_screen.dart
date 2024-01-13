import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_home_screen/clinic_home_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_home/components/appointments_components.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_home/components/clinic_alert.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/components/binding_counter.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/components/finished_counter.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/registration/registration_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/title_with_arrow_component.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../../../api/logout/logout_api.dart';
import '../../../../binding/registration/registration_binding.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/icons.dart';

class ClinicHomeScreen extends StatelessWidget {
  const ClinicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClinicHomeScreenCtrl>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text('Clinic'.tr),
          actions: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () {
                  Logout().logout();
                  MySharedPreferences.clearProfile();
                  Get.deleteAll(force: true);
                  Get.offAll(
                        () => const RegistrationScreen(),
                    binding: RegestirationBinding(),
                  );
                },
                child: MySharedPreferences.language == 'ar'
                    ? SvgPicture.asset(
                  MyIcons.signOut,
                  height: 40,
                  width: 40,
                  color: MyColors.blue14B,
                )
                    : RotationTransition(
                  turns: const AlwaysStoppedAnimation(
                      180 / 360),
                  child: SvgPicture.asset(
                    MyIcons.signOut,
                    height: 40,
                    width: 40,
                    color: MyColors.white,
                  ),
                ),
              ),
            ),
            // IconButton(
            //     onPressed: (){
            //       Logout().logout();
            //       MySharedPreferences.clearProfile();
            //       Get.deleteAll(force: true);
            //       Get.offAll(
            //             () => const RegistrationScreen(),
            //         binding: RegestirationBinding(),
            //       );
            //   Get.to(const RegistrationScreen());
            // }, icon: Icon( Icons.add))
          ],
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.pagingController.refresh();
              controller.fetchUrgentAppointments();
              controller.fetchAppointmentsCounter();
            },
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                controller.urgentsAppointments != 0
                    ? FadeInRight(
                        from: 20,
                        duration: const Duration(seconds: 1),
                        child: ClinicAlert(
                            urgentsAppointmentsCount:
                                controller.urgentsAppointments))
                    : const SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 37, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: FinishedCounter(
                              count: controller.finishedAppointments)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: BindingCounter(
                              count: controller.bindingAppointments)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GetBuilder<ClinicBaseNavBarCtrl>(
                    builder: (controller) => TitleWithArrowComponent(
                        title: 'Appointments'.tr,
                        onPressed: () =>
                            controller.navBarController.jumpToTab(1))),
                const SizedBox(height: 20),
                const ClinicAppointmentsComponent(),
                // const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
