import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../model/get_ratings/rating_model.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/icons.dart';
import '../../../../../utils/images.dart';

class RatingCard extends StatelessWidget {
  final RatingsDataModel? ratingData;

  const RatingCard({
    super.key,
    required this.ratingData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.grey7f8,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: -40,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: MyColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        MyImages.blankProfile,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            ratingData!.title.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          AbsorbPointer(
            absorbing: true,
            child: RatingBar(
              initialRating: ratingData!.points!.toDouble(),
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: SvgPicture.asset(
                  MyIcons.star,
                  height: 15,
                  width: 15,
                  color: MyColors.yellowf03,
                ),
                half: SvgPicture.asset(
                  MyIcons.star,
                  height: 15,
                  width: 15,
                  color: MyColors.greenc4e,
                ),
                empty: SvgPicture.asset(
                  MyIcons.star,
                  height: 15,
                  width: 15,
                  color: MyColors.textColor,
                ),
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                // print(rating);
              },
              itemSize: 20,
              maxRating: 0,
              tapOnlyMode: true,
              updateOnDrag: false,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Text(
              ratingData!.content.toString().tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: MyColors.textColor,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
