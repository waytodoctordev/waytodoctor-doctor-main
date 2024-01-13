import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          MyImages.offline,
          repeat: true,
          height: 200,
        ),
      ),
    );
  }
}
