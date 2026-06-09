import 'package:flutter/material.dart';

import '../../../../utils/images.dart';
import '../../model/user_other_doctors/user_other_doctors_model.dart';
import '../../utils/colors.dart';

class MyOtherDoctorsComponent extends StatelessWidget {
  final OtherDoctorsData doctor;
  const MyOtherDoctorsComponent({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: MyColors.grey7f8,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Image.asset(
            MyImages.blankProfile,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  doctor.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyColors.blue14B,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  doctor.specialization.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyColors.grey5d8,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  doctor.phone.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: MyColors.blue14B,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
