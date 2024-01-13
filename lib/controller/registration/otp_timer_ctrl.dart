import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OTPTimerCtrl extends GetxController {
  static OTPTimerCtrl get find => Get.find();

  Timer? timer;
  final counter = 60.obs;

  Future startTimer(BuildContext context) async {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) async {
        if (counter.value == 0) {
          update();
        } else {
          counter.value--;
          update();
        }
      },
    );
  }
}
