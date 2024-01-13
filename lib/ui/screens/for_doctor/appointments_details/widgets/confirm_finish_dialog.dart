import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments/doctor_appointments_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CustomFinishDialogBox extends StatefulWidget {
  final String appointmentId;
  final String patiendId;
  const CustomFinishDialogBox(
      {Key? key, required this.appointmentId, required this.patiendId})
      : super(key: key);

  @override
  State<CustomFinishDialogBox> createState() => _CustomFinishDialogBoxState();
}

class _CustomFinishDialogBoxState extends State<CustomFinishDialogBox> {
  @override
  void initState() {
    // Get.put(ClinincAppointmentsDetailsCtrl());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
             'Are you sure about ending the date?'.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: 'No'.tr,
                        textColor: MyColors.blue14B,
                        onPressed: () {
                          Get.back();
                        },
                        color: MyColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomElevatedButton(
                        title: 'Yes'.tr,
                        textColor: MyColors.white,
                        onPressed: () async {
                          await DoctorAppointmentsDetailsCtrl.find
                              .updateAppointmentStatus(
                                  appointmentId:
                                      widget.appointmentId.toString(),
                                  status: AppConstants.finished,
                                  context: context)
                              .whenComplete(
                            () async {
                              // TODO: هخلي أية تلغي من عندها
                              // await FirebaseFirestore.instance
                              //     .collection('chat')
                              //     .doc(
                              //         '${widget.patiendId}${MySharedPreferences.id}')
                              //     .update({
                              //   // 'isActive': false,
                              //   'canCall': false,
                              // });
                              Get.back();
                              await DoctorAppointmentsDetailsCtrl.find
                                  .initFetchAppointment(widget.appointmentId);
                              DoctorHomeScreenCtrl.find.pagingController
                                  .refresh();
                              DoctorAppointmentsCtrl.find.pagingController
                                  .refresh();
                              await DoctorHomeScreenCtrl.find
                                  .fetchUrgentAppointments();
                              await DoctorHomeScreenCtrl.find
                                  .fetchAppointmentsCounter();
                              Loader.hide();

                              // Get.offAll(const DoctorBaseNavBar(),
                              //     binding: DoctorBaseNavBarBinding());
                            },
                          ).whenComplete(() => Get.back());
                        },
                        color: MyColors.red101,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
