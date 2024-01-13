import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';

import '../../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../../utils/api_url.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/custom_image_viewer.dart';
import '../../../../widgets/custom_network_image.dart';

class ResearchesComponent extends StatelessWidget {
  final DoctorDetailsModel? doctor;

  const ResearchesComponent({
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
              'Research and studies'.tr,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () => DoctorDetailsCtrl.find.getStudies(context),
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
          child: doctor!.data!.studies!.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: doctor!.data!.studies!.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onLongPress: () async {
                      await DoctorDetailsCtrl.find.deleteStudies(
                          context: context,
                          id: doctor!.data!.studies![index].id.toString());
                    },
                    onTap: () async {
                      Get.to(() => CustomImageViewer(
                          image:
                              "${ApiUrl.mainUrl}/${doctor!.data!.studies![index].image.toString()}"));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: CustomNetworkImage(
                            url: doctor!.data!.studies![index].image.toString(),
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
                    style:
                        const TextStyle(fontSize: 14, color: MyColors.blue1dd4),
                  ),
                ),
        ),
      ],
    );
  }
}
