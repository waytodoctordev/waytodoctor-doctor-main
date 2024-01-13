import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/for_doctor/doctor_home_screen/doctor_home_ctrl.dart';
import 'package:way_to_doctor_doctor/model/home_screen/slider_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_doctor/home/widgets/slider_container.dart';
import 'package:way_to_doctor_doctor/ui/widgets/failed_widget.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorHomeScreenCtrl>(
      builder: (controller) => FutureBuilder<SlidersModel?>(
        future: controller.initializeSliderFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox(height: 172, child: LoadingIndicator());
            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                return SizedBox(
                  height: 172,
                  child: CarouselSlider.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index, realIndex) => FadeInLeft(
                      from: 10,
                      delay: const Duration(milliseconds: 200),
                      child: SliderContainer(
                        image: snapshot.data!.data![index].image.toString(),
                      ),
                    ),
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        scrollPhysics: const BouncingScrollPhysics(),
                        enableInfiniteScroll: false,
                        autoPlay: true),
                  ),
                );
              } else {
                return const FailedWidget();
              }
          }
        },
      ),
    );
  }
}
