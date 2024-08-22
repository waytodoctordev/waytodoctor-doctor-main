import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class CustomFormIndicator extends StatelessWidget {
  final cs.CarouselController carouselController;
  final int currentIndex;
  final int count;

  const CustomFormIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    required this.carouselController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cs.CarouselSlider.builder(
      itemCount: count,
      carouselController: carouselController,
      itemBuilder: (context, index, realIndex) => CircleAvatar(
        radius: 36,
        backgroundColor: currentIndex != index ? Colors.transparent : MyColors.blue9D1,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundColor: currentIndex != index ? MyColors.blue14B.withOpacity(0.6) : MyColors.blue14B,
            child: Text(
              '${index + 1}',
            ),
          ),
        ),
      ),
      options: cs.CarouselOptions(
        height: 50,
        enlargeCenterPage: true,
        viewportFraction: .2,
        initialPage: currentIndex,
        enlargeStrategy: cs.CenterPageEnlargeStrategy.height,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        enableInfiniteScroll: false,
      ),
    );
  }
}
