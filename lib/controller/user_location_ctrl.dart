import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class UserLocationCtrl extends GetxController {
  static UserLocationCtrl get find => Get.find();

  final permission = Rxn<LocationPermission>();

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  Future<void> getPermission() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        permission.value = LocationPermission.unableToDetermine;
        return;
      }

      LocationPermission perm = await Geolocator.checkPermission();

      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }

      if (perm == LocationPermission.deniedForever ||
          perm == LocationPermission.denied) {
        permission.value = perm;
        return;
      }

      permission.value = perm;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      getLocation(position.latitude, position.longitude);

    } catch (e) {
      log("Location error: $e");
    }
  }

  void getLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
    log("location:: lat: $lat lng: $lng");
    update();
  }

  @override
  void onInit() {
    super.onInit();

    /// 🔥 IMPORTANT: delay execution after UI starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPermission();
    });
  }
}