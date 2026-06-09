import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class AppointmentsCounter extends StatelessWidget {
  final int count;
  final String appointmentsNames;
  const AppointmentsCounter({
    super.key,
    required this.count, required this.appointmentsNames,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height *.08,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: MyColors.blue14B,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            appointmentsNames.tr,
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
