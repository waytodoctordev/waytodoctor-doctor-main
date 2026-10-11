import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/components/appointments_components.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/components/doctor_alert.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/components/appointments_counter.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/components/slider_component.dart';
import 'package:way_to_doctor_doctor/ui/widgets/title_with_arrow_component.dart';
import '../../../../utils/app_spacing.dart';
import '../available_doctors/available_doctors_section.dart';
import 'widgets/home_appbar.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorHomeScreenCtrl>(
      builder: (controller) => Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(120), child: HomeAppBar()),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              controller.refreshHome();
            },
            child: ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                if (controller.urgentAppointments.value != 0)
                  FadeInRight(
                      from: 20,
                      duration: const Duration(seconds: 1),
                      child: DoctorAlert(
                          urgentAppointmentsCount:
                              controller.urgentAppointments.value)),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 37, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                          child: AppointmentsCounter(
                        count: controller.finishedAppointments.value,
                        appointmentsNames: 'Finished',
                      )),
                      AppSpacing.w10,
                      Expanded(
                          child: AppointmentsCounter(
                        count: controller.bindingAppointments.value,
                        appointmentsNames: 'Coming',
                      )),
                    ],
                  ),
                ),
                AppSpacing.gap10,
                const SliderComponent(),
                AppSpacing.gap20,
                AvailableDoctorsSection(),
                AppSpacing.gap10,
                GetBuilder<DoctorBaseNavBarCtrl>(
                  builder: (navController) => TitleWithArrowComponent(
                    title: 'Appointments'.tr,
                    onPressed: () =>
                        navController.navBarController.jumpToTab(1),
                  ),
                ),
                AppSpacing.gap20,
                const AppointmentsComponent(),
                AppSpacing.gap20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
