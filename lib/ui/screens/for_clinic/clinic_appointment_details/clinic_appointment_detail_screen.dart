import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_appointments_details/clinic_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/model/update_appointment_for_clinic/update_appointment_for_clinic_api.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/components/appointment_place_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/components/case_type_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/components/clinic_appointment_header.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/components/communication_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/components/time_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/widgets/appointment_details_appbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_clinic/clinic_appointment_details/widgets/confirm_cancel_dialog.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

import '../../../../controller/for_clinic/clinic_home_screen/clinic_home_ctrl.dart';
import '../../../../controller/for_clinic/clininc_appointments/clinic_appointments_ctrl.dart';

class ClinicAppointmentDetailsScreen extends StatefulWidget {
  // final AppointmentData appointmentData;
  final String id;

  const ClinicAppointmentDetailsScreen({
    super.key,
    required this.id,

    // required this.appointmentData,
  });

  @override
  State<ClinicAppointmentDetailsScreen> createState() =>
      _ClinicAppointmentDetailsScreenState();
}

class _ClinicAppointmentDetailsScreenState
    extends State<ClinicAppointmentDetailsScreen> {
  @override
  void initState() {
    Get.lazyPut(() => ClinicAppointmentsCtrl());
    Get.lazyPut(() => ClinicHomeScreenCtrl());
    ClinincAppointmentsDetailsCtrl.find
        .initAppointmentDetails(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ClinincAppointmentsDetailsCtrl>(
        builder: (controller) => FutureBuilder<UpdateAppointmentModel?>(
          future: controller.initializeAppointmentForClinic,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  return SafeArea(
                    child: Column(
                      children: [
                        const ClinicAppointmentsDetailsAppbar(),
                        ClinicAppointmentHeader(
                          userName: snapshot.data!.data!.user!.name.toString(),
                          userPhoneNumber:
                              snapshot.data!.data!.user!.phone.toString(),
                          image: snapshot.data!.data!.user!.image.toString(),
                        ),
                        const SizedBox(height: 30),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(horizontal: 37),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              CaseTypeComponent(
                                  caseType:
                                      snapshot.data!.data!.type.toString()),
                              const SizedBox(height: 10),
                              ComunicationComponent(
                                  communication: snapshot
                                      .data!.data!.bookingType
                                      .toString()),
                              const SizedBox(height: 10),
                              TimeComponent(
                                  time: snapshot.data!.data!.time.toString(),
                                  date: snapshot.data!.data!.date.toString()),
                              const SizedBox(height: 10),
                              PlaceComponent(
                                  paymentMethod: snapshot
                                      .data!.data!.paymentMethod
                                      .toString(),
                                  place:
                                      snapshot.data!.data!.location.toString()),
                              const SizedBox(height: 10),
                              snapshot.data!.data!.status.toString() ==
                                          AppConstants.canceled ||
                                      snapshot.data!.data!.status.toString() ==
                                          AppConstants.canceled.tr
                                  ? const SizedBox()
                                  : OutlinedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return CustomDialogBox(
                                              appointmentId:
                                                  widget.id.toString(),
                                            );
                                          },
                                        );
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24.0),
                                            side: const BorderSide(
                                                width: 10, color: MyColors.red),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      child: Text(
                                        'Cancel'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: MyColors.red101,
                                        ),
                                      ),
                                    ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 20),
                                child: CustomElevatedButton(
                                  title: 'Save'.tr,
                                  onPressed: () {
                                    ClinincAppointmentsDetailsCtrl.find
                                        .updateAppointment(
                                      appointmentId: widget.id.toString(),
                                      status: snapshot.data!.data!.status
                                          .toString(),
                                      context: context,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const FailedWidget();
                }
            }
          },
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 20),
      //   child: CustomElevatedButton(
      //     title: 'Save'.tr,
      //     onPressed: () {
      //       ClinincAppointmentsDetailsCtrl.find.updateAppointment(
      //         appointmentId: widget.appointmentData.id.toString(),
      //         status: widget.appointmentData.status.toString(),
      //         context: context,
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
