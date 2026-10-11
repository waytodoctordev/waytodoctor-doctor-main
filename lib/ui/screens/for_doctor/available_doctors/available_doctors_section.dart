import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/horizontal_loading.dart';
import 'package:way_to_doctor_doctor/utils/app_spacing.dart';
import '../../../../binding/for_doctor/doctor_details/doctor_details_binding.dart';
import '../../../../controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/custom_network_image.dart';
import '../../../widgets/failed_widget.dart';
import '../../../widgets/loading_indicator.dart';
import '../../../widgets/vertical_loading.dart';
import 'doctor_details_screen.dart';

class AvailableDoctorsSection extends StatelessWidget {
  AvailableDoctorsSection({super.key});

  final doctorCtrl = DoctorHomeScreenCtrl.find;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorHomeScreenCtrl>(builder: (controller) {
      // Show loading indicator when data is being fetched
      if (controller.isLoading) {
        return SizedBox(
          height: Get.height * .14,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 10),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, __) => const DoctorLoadingItem(),
          ),
        );
      }
      // If there is no data, show a message
      if (controller.availableDoctors  == null ) {
        return SizedBox(
          height: Get.height * .15,
          child: ListView.separated(
            padding: const EdgeInsetsDirectional.only(start: 30, end: 10),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, __) => const DoctorLoadingItem(),
          ),
        );      }
      // If there is data, show It
      return SizedBox(
        height: Get.height * .17,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          separatorBuilder: (context, index) => AppSpacing.w10,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.only(start: 30, end: 10),
          physics: const BouncingScrollPhysics(),
          itemCount: controller.availableDoctors!.length,
          itemBuilder: (BuildContext context, int index) {
            return FadeInLeft(
              from: 30,
              delay: Duration(milliseconds: 10 * index),
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.45),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: CustomNetworkImage(
                            boxFit: BoxFit.cover,
                            url: controller.availableDoctors![index].image
                                .toString(),
                            radius: 50,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.to(
                          () => DoctorDetailsScreen(
                                doctorId: controller.availableDoctors![index].id
                                    .toString(),
                              ),
                          binding: DoctorDetailsBinding());
                    },
                  ),
                  AppSpacing.gap10,
                  Text(
                    controller.availableDoctors![index].name
                        .toString()
                        .split(' ')
                        .take(2)
                        .join(' '),
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 10,
                      color: MyColors.blue14B,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
