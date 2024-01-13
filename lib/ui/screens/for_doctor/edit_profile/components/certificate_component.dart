import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';

import '../../../../../utils/api_url.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/custom_image_viewer.dart';
import '../../../../widgets/custom_network_image.dart';

class CertificateComponent extends StatelessWidget {
  final DoctorDetailsModel? doctor;

  const CertificateComponent({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Medical Certificates'.tr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => DoctorDetailsCtrl.find.getCertificate(context),
              icon: const Icon(
                CupertinoIcons.add_circled_solid,
                color: MyColors.blue14B,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 100,
          child: doctor!.data!.certificates!.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: doctor!.data!.certificates!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPress: () async {
                      await DoctorDetailsCtrl.find.deleteCertificate(
                          context: context,
                          id: doctor!.data!.certificates![index].id.toString());
                      //   Get.to(() => CustomImageViewer(
                      //       image:
                      //           "${ApiUrl.mainUrl}/${doctor!.data!.certificates![index].image.toString()}"));
                    },
                    onTap: () => Get.to(() => CustomImageViewer(
                        image:
                            "${ApiUrl.mainUrl}/${doctor!.data!.certificates![index].image.toString()}")),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CustomNetworkImage(
                            url: doctor!.data!.certificates![index].image
                                .toString(),
                            radius: 24,
                            width: 100,
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          padding: const EdgeInsets.all(40),
                          decoration: BoxDecoration(
                              color: MyColors.grey5d8.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(24)),
                          child: const Icon(
                            CupertinoIcons.trash,
                            color: MyColors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    'No items'.tr,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: MyColors.blue1dd4,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
