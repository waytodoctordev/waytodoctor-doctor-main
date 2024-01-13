import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lottie/lottie.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class OverLayLoader {
  static void showLoading(
    BuildContext context, {
    Color color = MyColors.primary,
  }) {
    Loader.show(
      context,
      overlayColor: Colors.black26,
      progressIndicator: Center(
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
