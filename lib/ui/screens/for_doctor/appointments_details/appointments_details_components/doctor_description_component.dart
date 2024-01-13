import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_replays_ctrl.dart';
import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class DoctorDescriptionComponent extends StatefulWidget {
  final List<DoctorDescription?> doctorReplay;
  final String appointmentID;

  const DoctorDescriptionComponent(
      {super.key, required this.doctorReplay, required this.appointmentID});

  @override
  State<DoctorDescriptionComponent> createState() =>
      _DoctorDescriptionComponentState();
}

class _DoctorDescriptionComponentState
    extends State<DoctorDescriptionComponent> {
  @override
  void initState() {
    Get.put(DoctorreplaysCtrl());
    DoctorreplaysCtrl.find.initFetchReplays(widget.appointmentID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'doctor\'s explanations'.tr,
          style: const TextStyle(
            color: MyColors.blue14B,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        GetBuilder<DoctorreplaysCtrl>(
          builder: (controller) => FutureBuilder<ReplaysModel?>(
            future: controller.initializeReplaysFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const LoadingIndicator();
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    return CustomTextField(
                      hintText: snapshot.data!.data!.isEmpty
                          ? AppConstants.noItems
                          : snapshot.data!.data!.last.content,
                      maxLines: 4,
                      horizontalPadding: 20,
                      readOnly: true,
                      fillColor: MyColors.fillColor,
                    );
                  } else {
                    return const FailedWidget();
                  }
              }
            },
          ),
        ),
      ],
    );
  }
}
