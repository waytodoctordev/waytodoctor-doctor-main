import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/get_user_medical_infi_ctrl.dart';
import 'package:way_to_doctor_doctor/model/user_medical_info_model/user_medical_info_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PatientMedicalInformationComponent extends StatefulWidget {
  final String userId;
  const PatientMedicalInformationComponent({super.key, required this.userId});

  @override
  State<PatientMedicalInformationComponent> createState() =>
      _PatientMedicalInformationComponentState();
}

class _PatientMedicalInformationComponentState
    extends State<PatientMedicalInformationComponent> {
  @override
  void initState() {
    Get.put(UserMedicalCtrl());
    UserMedicalCtrl.find.initMedicalInfo(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMedicalCtrl>(
      builder: (controller) => FutureBuilder<MedicalInfoModel?>(
          future: controller.initializeMedicalInfoFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingIndicator();
              case ConnectionState.done:
              default:
                if (snapshot.hasData) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      return ExpansionTile(
                        title: Text(
                          snapshot.data!.data[index].question.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: MyColors.blue14B,
                          ),
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        initiallyExpanded: true,
                        childrenPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        expandedAlignment: MySharedPreferences.language == 'ar'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        children: [
                          Text(
                            snapshot.data!.data[index].answer.toString(),
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: MyColors.textColor,
                            ),
                          )
                        ],
                      );
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 37),
                  );
                } else {
                  return const FailedWidget();
                }
            }
          }),
    );
  }
}
