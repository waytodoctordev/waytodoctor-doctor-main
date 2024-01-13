import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_description_ctrl.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_replays_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/widgets/doctor_description_screen.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/appointments_details/widgets/doctor_replay_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class AddReplayOrDescriptionDialogw extends StatefulWidget {
  final String appointmentID;

  const AddReplayOrDescriptionDialogw({
    Key? key,
    required this.appointmentID,
  }) : super(key: key);

  @override
  State<AddReplayOrDescriptionDialogw> createState() =>
      _AddReplayOrDescriptionDialogwState();
}

class _AddReplayOrDescriptionDialogwState
    extends State<AddReplayOrDescriptionDialogw> {
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
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
              // width: 100,
              child: Center(
                child: CustomElevatedButton(
                  title: 'Add a prescription'.tr,
                  textColor: MyColors.white,
                  textSize: 14,
                  fontWeight: FontWeight.normal,
                  onPressed: () {
                    Get.back();
                    Get.to(() => DoctorDescriptionScreen(
                            appointmentID: widget.appointmentID))!
                        .whenComplete(() {
                      Future.delayed(
                        const Duration(seconds: 1),
                        () => DoctorDescriptionCtrl.find
                            .initFetchDescriptions(widget.appointmentID),
                      );
                    });
                  },
                  color: MyColors.blue14B,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              // width: 100,
              child: Center(
                child: CustomElevatedButton(
                  title: 'Add doctor\'s explanations'.tr,
                  textColor: MyColors.white,
                  textSize: 14,
                  fontWeight: FontWeight.normal,
                  onPressed: () {
                    Get.back();
                    Get.to(() => DoctorReplayScreen(
                            appointmentID: widget.appointmentID))!
                        .whenComplete(() {
                      Future.delayed(
                        const Duration(seconds: 1),
                        () => DoctorreplaysCtrl.find
                            .initFetchReplays(widget.appointmentID),
                      );
                    });
                  },
                  color: MyColors.blue14B,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
