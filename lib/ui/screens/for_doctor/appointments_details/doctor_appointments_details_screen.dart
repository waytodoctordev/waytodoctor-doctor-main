import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/view_appointment_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointment_details.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/appointments_details_components/appointment_header.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/patient_doctors_component/patient_doctors_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/patient_medical_information_component/patient_medical_information_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/patient_medical_insurance_component/patient_medical_insurance_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/patient_personal_information_component/patient_personal_information_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/widgets/add_replay_or_desc_dialog.dart.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/widgets/appointment_details_appbar.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/widgets/confirm_finish_dialog.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/widgets/payment_method_dialog.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/chat_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_slider_button.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import 'appointments_details_components/user_medical_history/user_medical_history_component.dart';

class DoctorAppointmentDetailsScreen extends StatefulWidget {
  final String appointmentId;
  final String bookingType;

  const DoctorAppointmentDetailsScreen({
    super.key,
    required this.appointmentId,
    required this.bookingType,
  });

  @override
  State<DoctorAppointmentDetailsScreen> createState() =>
      _DoctorAppointmentDetailsScreenState();
}

class _DoctorAppointmentDetailsScreenState
    extends State<DoctorAppointmentDetailsScreen> {

  final List<String> appointmentDetailsItems = [
    'Appointment Details'.tr,
    'Personal information'.tr,
    'Medical Information'.tr,
    'Medical Insurance'.tr,
    'Doctors'.tr,
    'Patient History'.tr,
  ];

  @override
  void initState() {
    super.initState();
    DoctorAppointmentsDetailsCtrl.find
        .initFetchAppointment(widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DoctorAppointmentsDetailsCtrl>(
        builder: (controller) => SafeArea(
          child: FutureBuilder<ViewAppointmentModel?>(
            future: controller.initializeAppointmentDetailsFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const LoadingIndicator();
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        AppointmentsDetailsAppbar(
                            appointmentId: snapshot.data!.data.id.toString()),
                        AppointmentHeader(
                          userName: snapshot.data!.data.user!.name.toString(),
                          appointmentPlace:
                              snapshot.data!.data.location.toString().tr,
                          image: snapshot.data!.data.user!.image.toString(),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 30,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            padding: const EdgeInsets.only(
                                left: 37, right: 37, bottom: 0),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => controller.getCurrentIndex(index),
                              child: Text(
                                appointmentDetailsItems[index],
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: controller.currentIndex != index
                                      ? MyColors.textColor
                                      : MyColors.blue14B,
                                  fontWeight:
                                      controller.currentIndex != index
                                          ? FontWeight.w400
                                          : FontWeight.bold,
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 5),
                            itemCount: 6,
                          ),
                        ),
                        Expanded(
                          child: PageView(
                            // physics: const NeverScrollableScrollPhysics(),
                            controller: controller.pageController,
                            onPageChanged: (value) =>controller.getCurrentIndex(value),
                            children: [
                              AppointmentDetails(
                                  appointmentData: snapshot.data!.data),
                              PatientPersonalInformationComponent(
                                fullName:
                                    '${snapshot.data!.data.user!.name} ${snapshot.data!.data.user!.secondName} ${snapshot.data!.data.user!.thirdName} ${snapshot.data!.data.user!.lastName}',
                                userDateOfBirth: snapshot
                                    .data!.data.user!.dateOfBirth
                                    .toString(),
                                userGender:
                                    snapshot.data!.data.user!.gender.toString(),
                                userMaritalStatus:
                                    snapshot.data!.data.user!.status.toString(),
                                userNationalId: snapshot
                                    .data!.data.user!.nationalId
                                    .toString(),
                              ),
                              PatientMedicalInformationComponent(
                                  userId:
                                      snapshot.data!.data.user!.id.toString()),
                              PatientMedicalInsuranceComponent(
                                userMedicalInsurance: snapshot
                                    .data!.data.user!.insuranceName
                                    .toString(),
                                hasInsurance: snapshot
                                    .data!.data.user!.insurance
                                    .toString(),
                              ),
                              PatientDoctorsComponent(
                                  userId:
                                      snapshot.data!.data.user!.id.toString()),
                              UserMedicalHistoryDetails(
                                  historyData: snapshot.data!.data),

                              // const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Spacer(),

                            snapshot.data!.data.status !=
                                        AppConstants.approved &&
                                    snapshot.data!.data.status !=
                                        AppConstants.finished
                                ? OutlinedButton(
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return PymentMethodDialogBox(
                                              appointmentId: snapshot
                                                  .data!.data.id
                                                  .toString(),
                                              patiendId: snapshot
                                                  .data!.data.user!.id
                                                  .toString());
                                        },
                                      );
                                      // await controller
                                      //     .updateAppointmentStatus(
                                      //   appointmentId:
                                      //       widget.appointmentId.toString(),
                                      //   status: AppConstants.approved,
                                      //   context: context,
                                      // )
                                      //     .whenComplete(() async {
                                      //   await controller.initFetchAppointment(
                                      //     snapshot.data!.data.id.toString(),
                                      //   );
                                      // });
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24.0),
                                          side: const BorderSide(
                                              width: 10,
                                              color: MyColors.blue14B),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    child: Text('Accept'.tr,

                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: MyColors.blue14B,
                                      ),
                                    ),
                                  )
                                : const SizedBox(width: 5),

                            snapshot.data!.data.status != AppConstants.approved
                                ? const SizedBox(width: 40)
                                : const SizedBox(),
                            snapshot.data!.data.status != AppConstants.finished
                                ? OutlinedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return CustomFinishDialogBox(
                                            appointmentId: snapshot
                                                .data!.data.id
                                                .toString(),
                                            patiendId: snapshot
                                                .data!.data.user!.id
                                                .toString(),
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
                                      'Finish'.tr,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: MyColors.red101,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Padding(
                          padding: controller.currentIndex == 0
                              ? const EdgeInsetsDirectional.only(
                                  start: 37, end: 10, bottom: 20, top: 0)
                              : const EdgeInsetsDirectional.only(
                                  start: 37, end: 37, bottom: 20, top: 0),
                          child: Row(
                            children: [
                              Expanded(
                                child: StreamBuilder(
                                  stream: AppConstants()
                                      .fireAgoraStreamForAppointment(),
                                  builder: (context, agoraSnapshot) {
                                    if (agoraSnapshot.hasError) {
                                      return const SizedBox.shrink();
                                    }

                                    if (agoraSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox.shrink();
                                    }

                                    if (agoraSnapshot.data!.docs.isEmpty) {
                                      return const SizedBox.shrink();
                                    }

                                    final agoraModel =
                                        agoraSnapshot.data!.docs[0].data();

                                    if (agoraModel.isActive &&
                                        snapshot.data!.data.status ==
                                            AppConstants.approved) {
                                      return  SlideAction(
                                        trackBuilder: (context, state) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 8,
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                  'Contact with patient'.tr
                                              ),
                                            ),
                                          );
                                        },
                                        thumbBuilder: (context, state) {
                                          return Container(
                                            margin: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: MyColors.blue14B,
                                              borderRadius: BorderRadius.circular(50),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.call,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                        action: () async {
                                          if (snapshot.data!.data
                                                      .bookingType! ==
                                                  AppConstants.clinic.tr ||
                                              snapshot.data!.data
                                                      .bookingType! ==
                                                  AppConstants.clinic) {
                                            final Uri phoneNumber = Uri.parse(
                                                'tel:${snapshot.data!.data.user!.phone!}');
                                            await launchUrl(
                                              phoneNumber,
                                              mode: LaunchMode
                                                  .externalApplication,
                                            );
                                          } else {
                                            log(widget.bookingType);
                                            Get.to(
                                              () => ChatScreen(
                                                // agoraModel: agoraModel,
                                                patientId: snapshot
                                                    .data!.data.user!.id!,
                                                appointmentId: int.parse(
                                                    widget.appointmentId),
                                                bookingType: widget.bookingType,
                                                patientName: snapshot
                                                    .data!.data.user!.name!,
                                                status:
                                                    snapshot.data!.data.status!,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 5),
                              controller.currentIndex == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AddReplayOrDescriptionDialogw(
                                              appointmentID: snapshot
                                                  .data!.data.id
                                                  .toString(),
                                            );
                                          },
                                        );
                                      },
                                      // onTap: () => Get.to(
                                      //   () => DoctorReplayScreen(
                                      //     doctorReplay: appointmentData.replays!,
                                      //     appointmentID: appointmentData.id.toString(),
                                      //   ),
                                      // )!
                                      //     .whenComplete(() => DoctorDescriptionCtrl.find.initFetchDescriptions(appointmentData.id.toString())),
                                      child: Container(
                                        height: 55,
                                        width: 55,
                                        padding: const EdgeInsets.all(18),
                                        decoration: BoxDecoration(
                                            color: MyColors.blue14B,
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: SvgPicture.asset(
                                          MyIcons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(width: 5),
                            ],
                          ),
                        )
                      ],
                    );
                  } else {
                    return const FailedWidget();
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
