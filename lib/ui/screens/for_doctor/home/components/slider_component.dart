import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';

import '../../../../../utils/colors.dart';
import '../../../../widgets/custom_network_image.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<DoctorHomeScreenCtrl>(
        builder: (controller) {
          // Show loading indicator when data is being fetched
          if (controller.isLoading) {
            return const SizedBox(height: 172, child: LoadingIndicator());
          }
          // If there is no data, show a message
          if (controller.data == null ||
              controller.data!.isEmpty) {
            return const FailedWidget();          }
          return SizedBox(
            height: Get.height *.2,
            child: CarouselSlider.builder(
              itemCount: controller.data!.length,
              itemBuilder: (context, index, realIndex) => FadeInLeft(
                from: 10,
                delay: const Duration(milliseconds: 200),
                child: Container(
      height: Get.height*.17,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.blue9D1,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: CustomNetworkImage(url: controller.data![index].image!, radius: 24),
          ),
        ],
      ),
    )
              ),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  enableInfiniteScroll: false,
                  autoPlay: true),
            ),
          );

        },
      );
  }}
///Done: old code nancy amro developer has developed it to the one above
    //   GetBuilder<DoctorHomeScreenCtrl>(
    //   builder: (controller) => FutureBuilder<List<SlidersModel?>>(
    //     future: controller.initializeSliderFuture,
    //     builder: (context, snapshot) {
    //       switch (snapshot.connectionState) {
    //         case ConnectionState.waiting:
    //           return const SizedBox(height: 172, child: LoadingIndicator());
    //         case ConnectionState.done:
    //         default:
    //           if (snapshot.hasData) {
    //             return SizedBox(
    //               height: 172,
    //               child: CarouselSlider.builder(
    //                 itemCount: controller!.data!.length,
    //                 itemBuilder: (context, index, realIndex) => FadeInLeft(
    //                   from: 10,
    //                   delay: const Duration(milliseconds: 200),
    //                   child: SliderContainer(
    //                     image: controller!.data![index].image.toString(),
    //                   ),
    //                 ),
    //                 options: CarouselOptions(
    //                     enlargeCenterPage: true,
    //                     scrollPhysics: const BouncingScrollPhysics(),
    //                     enableInfiniteScroll: false,
    //                     autoPlay: true),
    //               ),
    //             );
    //           } else {
    //             return const FailedWidget();
    //           }
    //       }
    //     },
    //   ),
    // );
//   }
// }
