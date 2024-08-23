import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_doctor_doctor/controller/user_location_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/images.dart';

class MapController extends GetxController {
  static MapController get find => Get.find();

  GoogleMapController? mapController;
  double? mapLat;
  double? mapLng;

  Future displayPrediction(Prediction? p) async {
    if (p == null) return;
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: AppConstants.googleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    mapLat = lat;
    mapLng = lng;
    log("result:: $lat -- $lng");
    animateCamera(lat, lng);
  }

  Future<void> animateCamera(double lat, double lng) async {
    CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lng), zoom: 15));
    await mapController!.animateCamera(update);
  }

  Future<void> showSearchField(BuildContext context) async {
    try {
      Prediction? p = await PlacesAutocomplete.show(
        logo: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          width: double.infinity,
          child: Image.asset(MyImages.wayToDoctorLogo),
        ),
        offset: 0,
        radius: 1000,
        strictbounds: false,
        region: "JO",
        context: context,
        types: [
          // "(cities)",
          // "(regions)",
        ],
        hint: "Search for the address",
        apiKey: AppConstants.googleApiKey,
        onError: (PlacesAutocompleteResponse response) {
          log("error:: ${response.errorMessage}");
        },
        mode: Mode.overlay,
        language: "ar",
        components: [Component(Component.country, "JO")],
        startText: "city",
        //TODO: Deprecated -- Nancy
        // decoration: InputDecoration(
        //   hintText: 'Search',
        //   focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(20),
        //     borderSide: const BorderSide(
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
      );
      displayPrediction(p);
    } catch (e) {
      log("error:: $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future updateLocationDetails(
    GoogleMapController mapController,
    BuildContext context,
  ) async {
    OverLayLoader.showLoading(context);
    CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(mapLat!, mapLng!), zoom: 15));
    await mapController.animateCamera(update);
    Loader.hide();
    Get.back();
  }

  @override
  void onInit() {
    mapLat = UserLocationCtrl.find.latitude.value;
    mapLng = UserLocationCtrl.find.longitude.value;
    super.onInit();
  }
}
