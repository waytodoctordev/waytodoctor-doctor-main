import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import 'custom_network_image.dart';

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;

  const CategoryCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
            color: MyColors.blue14B,
            borderRadius: BorderRadius.circular(24),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CustomNetworkImage(url: image, radius: 24),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 114,
          child: Text(
            title,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 12,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
