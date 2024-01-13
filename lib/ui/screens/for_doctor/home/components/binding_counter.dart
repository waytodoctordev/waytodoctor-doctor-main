import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class BindingCounter extends StatelessWidget {
  final int count;

  const BindingCounter({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      // width: 173,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColors.blue14B,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Coming'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: MyColors.white,
            ),
          ),
          Text(
            count.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: MyColors.white,
            ),
          )
        ],
      ),
    );
  }
}
