import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_appointments_details/clinic_appointments_details.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_home_screen/clinic_home_ctrl.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/clinic_appointment_detail_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointments/components/clinic_appointment_card.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments/widgets/show_alertl_dialog.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/ui/widgets/vertical_loading.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class ClinicAppointmentsComponent extends StatelessWidget {
  const ClinicAppointmentsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, AppointmentData>.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      padding: const EdgeInsetsDirectional.only(start: 37, end: 37, bottom: 0),
      pagingController: ClinicHomeScreenCtrl.find.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        noItemsFoundIndicatorBuilder: (context) {
          return Center(
            child: Text(
              AppConstants.noItems,
              style: const TextStyle(color: MyColors.blue14B),
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return const BaseVerticalListLoading();
              },
            ),
          );
        },
        newPageProgressIndicatorBuilder: (context) {
          return const LoadingIndicator();
        },
        itemBuilder: (context, item, index) {
          return GestureDetector(
              onTap: () {
                if (item.status.toString() == AppConstants.finished ||
                    item.status.toString() == AppConstants.finished.tr ||
                    item.status.toString() == AppConstants.canceled ||
                    item.status.toString() == AppConstants.canceled.tr) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return const FinishedCustomDialogBox();
                    },
                  );
                } else {
                  Get.to(
                    () => ClinicAppointmentDetailsScreen(
                      id: item.id.toString(),
                    ),
                    binding: ClinicAppointmentsDetailsBinding(),
                  )!
                      .whenComplete(() {
                    // ClinicHomeScreenCtrl.find.fetchUrgentAppointments();
                    // ClinicHomeScreenCtrl.find.fetchAppointmentsCounter();
                    // ClinicHomeScreenCtrl.find.pagingController.refresh();
                  });
                }
                // print(appointmentData.userId);
              },
              child: ClinicAppointmentCard(appointmentData: item));
        },
      ),
    );
  }
}
