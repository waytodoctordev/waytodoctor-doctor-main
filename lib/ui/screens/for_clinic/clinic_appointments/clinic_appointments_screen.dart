import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:way_to_doctor_doctor/binding/for_clinic/clinic_appointments_details/clinic_appointments_details.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_home_screen/clinic_home_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clininc_appointments/clinic_appointments_ctrl.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/clinic_appointment_detail_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointments/components/clinic_appointment_card.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointments/widgets/clinic_appointments_appbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments/widgets/show_alertl_dialog.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/ui/widgets/vertical_loading.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class ClinicAppointmentsScreen extends StatelessWidget {
  const ClinicAppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          edgeOffset: 100,
          displacement: 60,
          onRefresh: () async {
            ClinicAppointmentsCtrl.find.pagingController.refresh();
            ClinicHomeScreenCtrl.find.fetchUrgentAppointments();
            ClinicHomeScreenCtrl.find.fetchAppointmentsCounter();
            ClinicHomeScreenCtrl.find.pagingController.refresh();
          },
          child: Column(
            children: [
              const ClinicAppointmentsScreenAppbar(),
              const SizedBox(height: 20),
              GetBuilder<ClinicAppointmentsCtrl>(
                builder: (controller) {
                  return Expanded(
                    child: PagedListView<int, AppointmentData>.separated(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.only(
                          bottom: 20, right: 37, left: 37),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      pagingController: controller.pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        noItemsFoundIndicatorBuilder: (context) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child: Lottie.asset(
                                    MyImages.noItems,
                                  ),
                                ),
                                Text(
                                  AppConstants.noItems,
                                  style:
                                      const TextStyle(color: MyColors.blue14B),
                                )
                              ],
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15),
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
                              if (item.status.toString() ==
                                      AppConstants.finished ||
                                  item.status.toString() ==
                                      AppConstants.finished.tr ||
                                  item.status.toString() ==
                                      AppConstants.canceled ||
                                  item.status.toString() ==
                                      AppConstants.canceled.tr) {
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
                                  // controller.pagingController.refresh();
                                  // ClinicHomeScreenCtrl.find
                                  //     .fetchUrgentAppointments();
                                  // ClinicHomeScreenCtrl.find
                                  //     .fetchAppointmentsCounter();
                                  // ClinicHomeScreenCtrl.find.pagingController
                                  //     .refresh();
                                });
                              }
                            },
                            child: ClinicAppointmentCard(
                              appointmentData: item,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
