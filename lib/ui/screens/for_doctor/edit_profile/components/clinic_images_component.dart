import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';

import '../../../../../controller/for_doctor/doctor_details/doctor_details_ctrl.dart';
import '../../../../../utils/api_url.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/custom_image_viewer.dart';
import '../../../../widgets/custom_network_image.dart';

class ClinicImagesComponent extends StatelessWidget {
  final DoctorDetailsModel? doctor;

  const ClinicImagesComponent({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsCtrl>(
      builder: (controller) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Clinic Pictures'.tr,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  color: MyColors.blue14B,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.getPictures(context),
                icon: const Icon(
                  CupertinoIcons.add_circled_solid,
                  color: MyColors.blue14B,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: doctor!.data!.pictures!.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: doctor!.data!.pictures!.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onLongPress: () async {
                          await controller.deletePictures(
                              context: context,
                              id: doctor!.data!.pictures![index].id.toString());
                        },
                        onTap: () async {
                          Get.to(() => CustomImageViewer(
                              image:
                                  "${ApiUrl.mainUrl}/${doctor!.data!.pictures![index].image.toString()}"));
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: CustomNetworkImage(
                                url: doctor!.data!.pictures![index].image
                                    .toString(),
                                radius: 28,
                              ),
                            ),
                            Container(
                              // width: 100,
                              // height: 100,
                              alignment: Alignment.center,
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
                      );
                    },
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      aspectRatio: 1,
                      viewportFraction: 0.7,
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
      ),
    );
  }
}
