import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/components/payment_component.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/doctor_details_shimmer.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/edit_profile/widgets/doctor_screen_appbar.dart';
import '../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../utils/colors.dart';
import 'components/certificate_component.dart';
import 'components/clinic_images_component.dart';
import 'components/description_component.dart';
import 'components/doctor_screen_header.dart';
import 'components/researches_component.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String doctorId;
  const DoctorDetailsScreen({
    super.key,
    required this.doctorId,
  });

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}


class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void initState() {
    super.initState();
    doctorDetailsCtrl = Get.put(DoctorDetailsCtrl());
    doctorDetailsCtrl.fetchDoctorDetailsData(doctorId: widget.doctorId, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DoctorDetailsCtrl>(
          builder: (controller) {
        return !controller.isLoading
            ? Stack(
          // alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                DoctorScreenAppbar(
                    doctorName: controller.doctor!.data!.name!),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        right: 37, left: 37, bottom: 50),
                    children: [
                      DoctorScreenHeader(
                        doctorDetails: controller.doctor!,
                      ),
                      const SizedBox(height: 20),
                      DescriptionComponent(
                          description: controller.doctor!.data!.description
                              .toString()),
                      // Text(
                      //   MySharedPreferences.language == 'ar'
                      //       ? 'ملاحظة : اضغط ضغطة مطولة علي الصور لفتحها'
                      //       : "Note : Long press on the images to open it",
                      //   style: const TextStyle(
                      //     color: MyColors.blue14B,
                      //     fontSize: 12,
                      //   ),
                      // ),
                      const SizedBox(height: 10),
                      Text(
                        'Long press to delete'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: MyColors.red,
                          // fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      PaymentComponent(doctor: controller.doctor!),
                      const SizedBox(height: 10),
                      CertificateComponent(doctor: controller.doctor!),
                      const SizedBox(height: 30),
                      ResearchesComponent(doctor: controller.doctor!),
                      const SizedBox(height: 30),
                      ClinicImagesComponent(doctor: controller.doctor!),

                    ],
                  ),
                ),
              ],
            ),
          ],
        )
            : const DoctorDetailsShimmer();
      }),
    );
  }
}

DoctorDetailsCtrl doctorDetailsCtrl = Get.put(DoctorDetailsCtrl());

// Expanded(
//                     child: ListView(
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.only(
//                           right: 37, left: 37, bottom: 50),
//                       children: [
//                         DoctorScreenHeader(
//                           doctorDetails: snapshot.data!,
//                         ),
//                         const SizedBox(height: 20),
//                         DescriptionComponent(
//                             description: snapshot
//                                 .data!.data!.description
//                                 .toString()),
//                         const SizedBox(height: 10),
//                         // Text(
//                         //   MySharedPreferences.language == 'ar'
//                         //       ? 'ملاحظة : اضغط ضغطة مطولة علي الصور لفتحها'
//                         //       : "Note : Long press on the images to open it",
//                         //   style: const TextStyle(
//                         //     color: MyColors.blue14B,
//                         //     fontSize: 12,
//                         //   ),
//                         // ),
//                         Text(
//                           'Long press to delete'.tr,
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             color: MyColors.blue14B,
//                             // fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         PaymentComponent(doctor: snapshot.data!),
//                         const SizedBox(height: 10),
//                         CertificateComponent(doctor: snapshot.data!),
//                         const SizedBox(height: 30),
//                         ResearchesComponent(doctor: snapshot.data!),
//                         const SizedBox(height: 30),
//                         ClinicImagesComponent(doctor: snapshot.data!),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         } else {
//           return const FailedWidget();
//         }
//     }
//   },
// ),
// ),),);

// ));
