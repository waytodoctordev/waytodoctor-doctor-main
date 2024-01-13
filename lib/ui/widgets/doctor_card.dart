import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_network_image.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/icons.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String categoryName;
  final String image;
  final double rating;

  const DoctorCard({
    super.key,
    required this.name,
    required this.categoryName,
    required this.image,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                height: Get.height*.15,
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: CustomNetworkImage(url: image, radius: 28),
                ),
              ),
              Container(
                width: 56,
                height: 23,
                margin: const EdgeInsets.only(bottom: 5, left: 5),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: MyColors.blue14B,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        double.parse((rating).toStringAsFixed(1)).toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: MyColors.white,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      MyIcons.star,
                      height: 12,
                      width: 12,
                      color: MyColors.yellowf03,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            name.tr,
            maxLines: 2,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 120,
            child: Text(
              categoryName.tr,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: MyColors.blue14B.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
