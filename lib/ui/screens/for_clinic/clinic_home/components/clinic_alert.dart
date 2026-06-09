import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class ClinicAlert extends StatelessWidget {
  final int urgentsAppointmentsCount;
  const ClinicAlert({
    super.key,
    required this.urgentsAppointmentsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 37, right: 37),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: MyColors.red101,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        '${'Warning: you have '.tr}$urgentsAppointmentsCount${' urgent appointments.'.tr}',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: MyColors.white,
        ),
      ),
    );
  }
}
