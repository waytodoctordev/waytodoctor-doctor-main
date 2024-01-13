import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_base_nav_bar_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clininc_appointments/clinic_appointments_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ClinicAppointmentsScreenAppbar extends StatelessWidget {
  const ClinicAppointmentsScreenAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () =>
            ClinicBaseNavBarCtrl.find.navBarController.jumpToTab(0),
        icon: MySharedPreferences.language == 'ar'
            ? RotationTransition(
                turns: const AlwaysStoppedAnimation(270 / 360),
                child: SvgPicture.asset(
                  MyIcons.angleSmallRight,
                  height: 7,
                  width: 7,
                  color: MyColors.blue14B,
                ),
              )
            : RotationTransition(
                turns: const AlwaysStoppedAnimation(90 / 360),
                child: SvgPicture.asset(
                  MyIcons.angleSmallRight,
                  height: 7,
                  width: 7,
                  color: MyColors.blue14B,
                ),
              ),
      ),
      leadingWidth: 80,
      flexibleSpace: Column(
        children: [
          const SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 37),
            child: GetBuilder<ClinicAppointmentsCtrl>(
              builder: (controller) => SizedBox(
                height: 50,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 5),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: controller.appointmentsType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomElevatedButton(
                      title: controller.appointmentsType[index],
                      fontWeight: FontWeight.normal,
                      height: 50,
                      textSize: 14,
                      width: 85,
                      color: controller.currentAppointmentTypeIndex != index
                          ? MyColors.grey7f8
                          : MyColors.blue14B,
                      textColor: controller.currentAppointmentTypeIndex != index
                          ? MyColors.blue14B
                          : MyColors.white,
                      onPressed: () {
                        if (controller.currentAppointmentTypeIndex != index) {
                          controller.getCurrentAppointmentTypeIndex(index);
                          controller.pagingController.refresh();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
      title: Text('Appointments'.tr),
    );
  }
}
