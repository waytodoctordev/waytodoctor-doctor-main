import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:way_to_doctor_doctor/controller/for_clinic/clinic_appointments_details/clinic_appointments_details_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class TimeComponent extends StatefulWidget {
  final String time;
  final String date;
  const TimeComponent({
    super.key,
    required this.time,
    required this.date,
  });

  @override
  State<TimeComponent> createState() => _TimeComponentState();
}

class _TimeComponentState extends State<TimeComponent> {
  @override
  void initState() {
    ClinincAppointmentsDetailsCtrl.find.currentTime = widget.time;
    ClinincAppointmentsDetailsCtrl.find.currentDate = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date : '.tr,
                style: const TextStyle(
                  color: MyColors.blue14B,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _showDatePicker(context),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColors.fillColor,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    ClinincAppointmentsDetailsCtrl.find.currentDate!
                        .split(' ')
                        .first,
                    style: const TextStyle(
                      color: MyColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Time : '.tr,
                style: const TextStyle(
                  color: MyColors.blue14B,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _showTimePicker(context),
                child: Container(
                  height: 60,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: MyColors.fillColor,
                      borderRadius: BorderRadius.circular(24)),
                  // TODO: change time format for clinic in appointment details screen
                  child: Text(
                    // int.parse(ClinincAppointmentsDetailsCtrl.find.currentTime
                    //             .toString()
                    //             .split(':')[0]) >
                    //         12
                    //     ? 'PM ${ClinincAppointmentsDetailsCtrl.find.currentTime!}'
                    //     : 'AM ${ClinincAppointmentsDetailsCtrl.find.currentTime!}',

                    DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(
                        ClinincAppointmentsDetailsCtrl.find.currentTime
                            .toString())),
                    style: const TextStyle(
                      color: MyColors.textColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showTimePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 200,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (val) {
                  String pickedTime =
                      val.toString().split(' ')[1].split('.000')[0];
                  String hr = pickedTime.split(':')[0];
                  String min = pickedTime.split(':')[1];

                  if (int.parse(hr) > 12) {
                    String fullTime = "$hr:$min";
                    ClinincAppointmentsDetailsCtrl.find.setTime(fullTime);
                  } else {
                    String fullTime = "$hr:$min";
                    ClinincAppointmentsDetailsCtrl.find.setTime(fullTime);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
      context: ctx,
      builder: (_) => Container(
        height: 250,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  String pickedDate = val.toString().split(' ')[0];
                  ClinincAppointmentsDetailsCtrl.find.setDate(pickedDate);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
