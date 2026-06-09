import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/for_doctor/settings/settings_ctrl.dart';

void showCustomCupertinoModalPopup({
  required BuildContext context,
  required CupertinoDatePickerMode mode,
  DateTime? initialDateTime,
  Color backgroundColor = Colors.white,
  double height = 200.0,
  required Function(DateTime) onDateTimeChanged,
  double? pickerHeight,
  Widget? customTitle,
  String? type,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => Container(
      height: height,
      color: backgroundColor,
      child: Column(
        children: [
          // Add a custom title if provided
          if (customTitle != null) customTitle,
          SizedBox(
            height: pickerHeight ?? 200.0, // Allows height customization of the picker
            child: CupertinoDatePicker(
              initialDateTime: initialDateTime ?? DateTime.now(),
              mode: mode,
              onDateTimeChanged: (DateTime val) {
                String pickedTime = val.toString().split(' ')[1].split('.000')[0];
                String hr = pickedTime.split(':')[0];
                String min = pickedTime.split(':')[1];
                String fullTime = "$hr:$min";

                // Custom logic based on `type` parameter
                if (type == 'from') {
                  if (int.parse(hr) > 12) {
                    // You can change this logic or use a callback function
                    SettingsCtrl.find.getFridayFromHour(fullTime);
                  } else {
                    SettingsCtrl.find.getFridayFromHour(fullTime);
                  }
                } else {
                  if (int.parse(hr) > 12) {
                    SettingsCtrl.find.getFridayToHour(fullTime);
                  } else {
                    SettingsCtrl.find.getFridayToHour(fullTime);
                  }
                }

                // Callback function to handle the date/time change
                onDateTimeChanged(val);
              },
            ),
          ),
        ],
      ),
    ),
  );
}
