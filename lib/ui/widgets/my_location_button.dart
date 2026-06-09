import 'package:flutter/material.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // MapController.find.animateCamera(UserLocationCtrl.find.latitude.value, UserLocationCtrl.find.longitude.value);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.white,
        shape: const CircleBorder(),
      ),
      child: const Icon(Icons.my_location),
    );
  }
}
