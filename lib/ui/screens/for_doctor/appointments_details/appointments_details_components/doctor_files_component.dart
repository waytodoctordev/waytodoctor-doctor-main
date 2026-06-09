import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_appointments_details/doctor_description_ctrl.dart';
import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class DoctorFilesComponents extends StatefulWidget {
  final List<DoctorDescription?> doctorDescription;
  final String appointmentID;

  const DoctorFilesComponents({
    super.key,
    required this.doctorDescription,
    required this.appointmentID,
  });

  @override
  State<DoctorFilesComponents> createState() => _DoctorFilesComponentsState();
}

class _DoctorFilesComponentsState extends State<DoctorFilesComponents> {
  @override
  void initState() {
    Get.put(DoctorDescriptionCtrl());
    DoctorDescriptionCtrl.find.initFetchDescriptions(widget.appointmentID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDescriptionCtrl>(
      builder: (controller) => SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.blue14B,
                  radius: 12,
                  child: SvgPicture.asset(
                    MyIcons.clip,
                    height: 10,
                    width: 10,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'prescription'.tr,
                    style: const TextStyle(
                      color: MyColors.blue14B,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<ReplaysModel?>(
                future: controller.initializeDescriptionFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const LoadingIndicator();
                    case ConnectionState.done:
                    default:
                      if (snapshot.hasData) {
                        return snapshot.data!.data!.isEmpty
                            ? SizedBox(
                                height: 40,
                                child: Text(AppConstants.noItems),
                              )
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) => const SizedBox(width: 10),
                                itemCount: snapshot.data!.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(18),
                                    onTap: () async {
                                      await launchUrl(
                                        Uri.parse('${ApiUrl.mainUrl}/${snapshot.data!.data![index].file}'),
                                        mode: LaunchMode.externalApplication,
                                      );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: MyColors.fillColor, borderRadius: BorderRadius.circular(18)),
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        snapshot.data!.data![index].file.toString().split('/').last,
                                        // controller.pickedFiles[index].toString().split('/').last,
                                        style: const TextStyle(
                                          color: MyColors.textColor,
                                          fontSize: 14,
                                          // fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      } else {
                        return const FailedWidget();
                      }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
