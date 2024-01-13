import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class FormAppbar extends StatelessWidget {
  final String sectionName;
  final String sectionDescription;
  const FormAppbar({
    super.key,
    required this.sectionName,
    required this.sectionDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            sectionName,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          height: 67,
          decoration: BoxDecoration(
            color: MyColors.blue9D1,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Text(
            'Make sure you enter correct data and information.'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: MyColors.blue14B,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          sectionDescription,
          // 'sction description',
          style: const TextStyle(
            fontSize: 16,
            color: MyColors.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
