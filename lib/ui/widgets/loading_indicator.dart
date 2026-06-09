import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Lottie.asset(
            MyImages.heartLoading,
          ),
        ),
      ),
    );
  }
}
