import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/controller/map.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        MapController.find.animateCamera(UserLocationCtrl.find.latitude.value, UserLocationCtrl.find.longitude.value);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primary,
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.my_location),
    );
  }
}
