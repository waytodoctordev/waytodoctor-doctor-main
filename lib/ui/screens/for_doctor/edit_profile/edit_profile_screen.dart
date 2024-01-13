import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/components/payment_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/doctor_details_shimmer.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/doctor_screen_appbar.dart';

import '../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../model/doctor_model/doctor_model.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../widgets/failed_widget.dart';
import 'components/certificate_component.dart';
import 'components/clinic_images_component.dart';
import 'components/description_component.dart';
import 'components/doctor_screen_header.dart';
import 'components/researches_component.dart';

class DoctorDetailsScreen extends StatelessWidget {
 final String? doctorId;
  const DoctorDetailsScreen({
    Key? key, required this.doctorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySharedPreferences.id = int.parse(doctorId!);
    return Scaffold(
      body: GetBuilder<DoctorDetailsCtrl>(
        builder: (controller) => SafeArea(
          child: FutureBuilder<DoctorDetailsModel?>(
            future: controller.initializeDoctorDetailsFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const DoctorDetailsShimmer();
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    return Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Column(
                          children: [
                            const DoctorScreenlAppbar(),
                            Expanded(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    right: 37, left: 37, bottom: 50),
                                children: [
                                  DoctorScreenHeader(
                                    doctorDetails: snapshot.data!,
                                  ),
                                  const SizedBox(height: 20),
                                  DescriptionComponent(
                                      description: snapshot
                                          .data!.data!.description
                                          .toString()),
                                  const SizedBox(height: 10),
                                  // Text(
                                  //   MySharedPreferences.language == 'ar'
                                  //       ? 'ملاحظة : اضغط ضغطة مطولة علي الصور لفتحها'
                                  //       : "Note : Long press on the images to open it",
                                  //   style: const TextStyle(
                                  //     color: MyColors.blue14B,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  Text(
                                   'Long press to delete'.tr,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: MyColors.blue14B,
                                      // fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  PaymentComponent(doctor: snapshot.data!),
                                  const SizedBox(height: 10),
                                  CertificateComponent(doctor: snapshot.data!),
                                  const SizedBox(height: 30),
                                  ResearchesComponent(doctor: snapshot.data!),
                                  const SizedBox(height: 30),
                                  ClinicImagesComponent(doctor: snapshot.data!),
                                ],
                              ),
                            ),
                          ],
                        ),
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
