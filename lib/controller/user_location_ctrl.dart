import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class UserLocationCtrl extends GetxController {
  static UserLocationCtrl get find => Get.find();

  final permission = Rxn<LocationPermission>();

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  final deniedPermissions = [
    LocationPermission.denied,
    LocationPermission.deniedForever,
    LocationPermission.unableToDetermine,
  ];

  Future<LocationPermission> getPermission() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      permission.value = LocationPermission.unableToDetermine;
      return permission.value!;
    }

    permission.value = await Geolocator.checkPermission();

    if (permission.value == LocationPermission.denied) {
      permission.value = await Geolocator.requestPermission();
    }

    if (permission.value == LocationPermission.denied) {
      permission.value = LocationPermission.denied;
      return permission.value!;
    }

    if (permission.value == LocationPermission.deniedForever) {
      permission.value = LocationPermission.deniedForever;
      return permission.value!;
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    getLocation(position.latitude, position.longitude);
    return permission.value!;
  }

  void getLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
    log("location:: lat: ${latitude.value}  lng: ${longitude.value}");
    update();
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }
}
