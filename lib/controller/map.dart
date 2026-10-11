import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
// import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:http/http.dart' as http;

import '../utils/shared_prefrences.dart';

class MapController extends GetxController {
  static MapController get find => Get.find();
  // List<AutocompletePrediction>
  GoogleMapController? mapController;
  double mapLat = 31.9539; // Amman default
  double mapLng = 35.9106;
  String? countryCode;

  List<Marker> markers = [
    Marker(
        markerId: const MarkerId('1'),
        position: LatLng(MySharedPreferences.lat, MySharedPreferences.long))
  ];
  @override
  void onInit() {
    currentLocation();
    mapLat = UserLocationCtrl.find.latitude.value;
    mapLng = UserLocationCtrl.find.longitude.value;
    super.onInit();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.

  Future<Position?> currentLocation() async {
    print('currentLocation');
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
       print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }
    print('serviceEnabled $serviceEnabled');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    print('position altitude ${position.latitude}');
    print('position longitude ${position.longitude}');
    MySharedPreferences.lat = position.latitude;
    MySharedPreferences.long = position.longitude;
     mapLat = position.latitude;
     mapLng = position.longitude;
    update();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    //32.563294442604494 -- 35.88275548070669
    countryCode = await getCountryCode(position.latitude, position.longitude);
    return position;
  }

  void placeAutoComplete(String place) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      'input': place,
      'key': 'AIzaSyAWJ3upm1raY_f9lnTd4HFybEyTnN5Fp0g',
    });
    final response = await http.get(uri);
    final jsonData = jsonDecode(response.body);
    final predictions = jsonData['predictions'] as List;

    print(predictions);
  }

  Future<String?> getCountryCode(double latitude, double longitude) async {
    print('getCountryCode $latitude $longitude' );
    final apiKey =
        'AIzaSyAnfh0DpOOyJ9Y9LUduYyqTnffqCJm0teU'; // Replace with your API Key
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    print('response ${response.body}');
    if (response.statusCode == 200) {
      print('response.statusCode  ${response.statusCode}');

      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final addressComponents =
            results[0]['address_components'] as List<dynamic>;
        final countryComponent = addressComponents.firstWhere(
          (component) =>
              (component['types'] as List<dynamic>).contains('country'),
          orElse: () => null,
        );
        print('getCountryCode ${countryComponent['short_name']}');
        return countryComponent != null
            ? countryComponent['short_name'] as String
            : null;
      }
    }
    return null;
  }

  Future<void> animateCamera(double lat, double lng) async {
    CameraUpdate update = CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 15));
    await mapController!.animateCamera(update);
  }

  Future updateLocationDetails(
    GoogleMapController mapController,
    BuildContext context,
  ) async {
    OverLayLoader.showLoading(context);
    CameraUpdate update = CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(mapLat!, mapLng!), zoom: 15));
    await mapController.animateCamera(update);
    Loader.hide();
    Get.back();
  }

  void moveToLocation(double lat, double lng) {
    mapLat = lat;
    mapLng = lng;
    markers
      ..clear()
      ..add(
        Marker(
          markerId: const MarkerId('selected'),
          position: LatLng(lat, lng),
        ),
      );

    animateCamera(
      lat,
      lng,
    );

    update();
  }
}
