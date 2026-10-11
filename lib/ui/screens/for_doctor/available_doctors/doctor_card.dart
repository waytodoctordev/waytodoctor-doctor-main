import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/custom_network_image.dart';
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
    return  SizedBox(
      height: Get.size.height *.6 ,
      width: Get.size.width*.35,//160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.white12),
                  borderRadius: BorderRadius.circular(28),

                ),
                height:  Get.size.height*.22,
                width:  Get.size.width*.36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: CustomNetworkImage(
                    url: image,
                    radius: 20,

                  ),
                ),
              ),
              Container(
                width: 56,
                height: 23,
                margin: const EdgeInsets.only(bottom: 10, left: 10),
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
                        double.parse((rating).toStringAsFixed(1))
                            .toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: MyColors.white,
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name.tr,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: const TextStyle(
              overflow: TextOverflow.clip,
              fontSize: 12,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 120,
            child: Text(
              categoryName.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: MyColors.blue14B.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
