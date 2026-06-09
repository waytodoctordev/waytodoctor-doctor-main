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
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return null;
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }
    print('serviceEnabled $serviceEnabled');
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
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
    update();
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    //32.563294442604494 -- 35.88275548070669
    countryCode = await getCountryCode(position.latitude,position.longitude);
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
    print('getCountryCode');
    final apiKey = 'AIzaSyAnfh0DpOOyJ9Y9LUduYyqTnffqCJm0teU';  // Replace with your API Key
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    final response = await http.get(Uri.parse(url));
print('response ${response.body}');
    if (response.statusCode == 200) {
      print('response.statusCode  ${response.statusCode }');

      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final addressComponents = results[0]['address_components'] as List<dynamic>;
        final countryComponent = addressComponents.firstWhere(
              (component) => (component['types'] as List<dynamic>).contains('country'),
          orElse: () => null,
        );
        print('getCountryCode ${countryComponent['short_name']}');
        return countryComponent != null ? countryComponent['short_name'] as String : null;
      }
    }
    return null;
  }
  // Future displayPrediction(Prediction? p) async {
  //   if (p == null) return;
  //   GoogleMapsPlaces places = GoogleMapsPlaces(
  //     apiKey: AppConstants.googleApiKey,
  //     apiHeaders: await const GoogleApiHeaders().getHeaders(),
  //   );
  //   PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
  //   final lat = detail.result.geometry!.location.lat;
  //   final lng = detail.result.geometry!.location.lng;
  //   mapLat = lat;
  //   mapLng = lng;
  //   log("result:: $lat -- $lng");
  //   animateCamera(lat, lng);
  // }

  Future<void> animateCamera(double lat, double lng) async {
    CameraUpdate update = CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 15));
    await mapController!.animateCamera(update);
  }

  Future<void> showSearchField(BuildContext context) async {
    // try {
    //   Prediction? p = await PlacesAutocomplete.show(
    //     logo: Container(
    //       height: 50,
    //       padding: const EdgeInsets.symmetric(vertical: 8),
    //       alignment: Alignment.center,
    //       width: double.infinity,
    //       child: Image.asset(MyImages.wayToDoctorLogo),
    //     ),
    //     offset: 0,
    //     radius: 1000,
    //     strictbounds: false,
    //     region: "JO",
    //     context: context,
    //     types: [
    //       // "(cities)",
    //       // "(regions)",
    //     ],
    //     hint: "Search for the address",
    //     apiKey: AppConstants.googleApiKey,
    //     onError: (PlacesAutocompleteResponse response) {
    //       log("error:: ${response.errorMessage}");
    //     },
    //     mode: Mode.overlay,
    //     language: "ar",
    //     components: [Component(Component.country, "JO")],
    //     startText: "city",
    //     //TODO: Deprecated -- Nancy
    //     // decoration: InputDecoration(
    //     //   hintText: 'Search',
    //     //   focusedBorder: OutlineInputBorder(
    //     //     borderRadius: BorderRadius.circular(20),
    //     //     borderSide: const BorderSide(
    //     //       color: Colors.white,
    //     //     ),
    //     //   ),
    //     // ),
    //   );
    //   displayPrediction(p);
    // } catch (e) {
    //   log("error:: $e");
    //   Fluttertoast.showToast(msg: e.toString());
    // }
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
}
