import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_appointments_details/clinic_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CustomDialogBox extends StatefulWidget {
  final String appointmentId;

  const CustomDialogBox({Key? key, required this.appointmentId})
      : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
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
              MySharedPreferences.language == 'ar'
                  ? 'هل أنت متأكد من إلغاء الموعد؟'
                  : "Are you sure",
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
                          await ClinincAppointmentsDetailsCtrl.find
                              .updateAppointment(
                            appointmentId: widget.appointmentId.toString(),
                            status: AppConstants.canceled,
                            context: context,
                          )
                              .whenComplete(() async {
                            Get.back();
                            // TODO: هخلي أية تلغي من عندها

                            // await FirebaseFirestore.instance
                            //     .collection('chat')
                            //     .doc(
                            //         '${widget.patientId}${MySharedPreferences.id}')
                            //     .update({
                            //   // 'isActive': false,
                            //   'canCall': false,
                            //   'token': '',
                            // });
                          });
                          Get.back();
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
