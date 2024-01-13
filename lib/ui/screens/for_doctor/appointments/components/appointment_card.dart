import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/appointments_details/appointments_details_binding.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments/widgets/show_alertl_dialog.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/doctor_appointments_details_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class MyAppointmentCard extends StatelessWidget {
  final AppointmentData appointmentData;

  const MyAppointmentCard({
    super.key,
    required this.appointmentData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (appointmentData.status.toString() == AppConstants.finished ||
            appointmentData.status.toString() == AppConstants.finished.tr ||
            appointmentData.status.toString() == AppConstants.canceled ||
            appointmentData.status.toString() == AppConstants.canceled.tr) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const FinishedCustomDialogBox();
            },
          );
        } else {
          Get.to(
              () => DoctorAppointmentDetailsScreen(
                    appointmentId: appointmentData.id.toString(),
                    bookingType: appointmentData.bookingType.toString(),
                  ),
              binding: AppointmentsDetailsBinding());
        }
      },
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width - 50,
        padding:
            const EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: MyColors.grey7f8,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CustomNetworkImage(
                      url: appointmentData.user!.image.toString(),
                      radius: 28,
                      width: 110,
                      height: 140,
                    ),
                  ),
                  appointmentData.status.toString() == AppConstants.finished ||
                          appointmentData.status.toString() ==
                              AppConstants.finished.tr
                      ? Container(
                          width: 110,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(24)),
                          child: Text(
                            AppConstants.finished.tr,
                            style: const TextStyle(
                              color: MyColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  appointmentData.status.toString() == AppConstants.canceled ||
                          appointmentData.status.toString() ==
                              AppConstants.canceled.tr
                      ? Container(
                          width: 110,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(24)),
                          child: Text(
                            AppConstants.canceled.tr,
                            style: const TextStyle(
                              color: MyColors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '#${appointmentData.id.toString()}',
                        style: const TextStyle(
                          color: MyColors.blue14B,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 5)
                    ],
                  ),
                  Text(
                    appointmentData.user!.name.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: MyColors.blue14B,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Text(
                  //   appointmentData.user!.secondName.toString(),
                  //   style: const TextStyle(
                  //     color: MyColors.textColor,
                  //     fontSize: 14,
                  //   ),
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      _typeIconBuilder(
                          appointmentData.bookingType.toString().tr),
                      const SizedBox(width: 5),
                      Text(
                        appointmentData.bookingType.toString().tr,
                        style: const TextStyle(
                          color: MyColors.textColor,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      SvgPicture.asset(
                        MyIcons.timer,
                        height: 11,
                        width: 11,
                        color: MyColors.blue14B,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat('hh:mm a').format(DateFormat('HH:mm')
                            .parse(appointmentData.time.toString())),
                        // int.parse(appointmentData.time
                        //             .toString()
                        //             .split(':')[0]) >=
                        //         12
                        //     ? "PM ${int.parse(appointmentData.time.toString().split(':')[0]) - 12}:${appointmentData.time.toString().split(':')[1]}"
                        //     : "AM ${appointmentData.time.toString().split(':')[0]}:${appointmentData.time.toString().split(':')[1]}",
                        style: const TextStyle(
                          color: MyColors.textColor,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        MyIcons.date,
                        height: 7,
                        color: MyColors.blue14B,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        appointmentData.date.toString().split(' ')[0],
                        style: const TextStyle(
                          color: MyColors.textColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            appointmentData.type.toString().tr == 'Urgent'.tr
                                ? MyColors.red
                                : appointmentData.type.toString().tr ==
                                        'Consultation'.tr
                                    ? MyColors.yellowf03
                                    : MyColors.greenc4e,
                        radius: 5,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        appointmentData.type.toString().tr,
                        style: const TextStyle(
                          color: MyColors.textColor,
                          textBaseline: TextBaseline.alphabetic,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                  // status
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _typeIconBuilder(String bookingType) {
  if (bookingType == 'Chat'.tr) {
    return SvgPicture.asset(
      MyIcons.chat,
      height: 11,
      color: MyColors.blue14B,
    );
  }

  if (bookingType == 'Video'.tr) {
    return SvgPicture.asset(
      MyIcons.video,
      height: 8.5,
      color: MyColors.blue14B,
    );
  }

  if (bookingType == 'Clinic'.tr) {
    return SvgPicture.asset(
      MyIcons.building,
      height: 11,
      color: MyColors.blue14B,
    );
  }
  if (bookingType == 'Call'.tr) {
    return SvgPicture.asset(
      MyIcons.call,
      height: 11,
      color: MyColors.blue14B,
    );
  } else {
    return const SizedBox();
  }
}
