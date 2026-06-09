import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:way_to_doctor_doctor/controller/map.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_marker.dart';
import 'package:way_to_doctor_doctor/ui/widgets/my_location_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../controller/for_doctor/settings/settings_ctrl.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({
    super.key,
    // required this.mapController,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = Get.put(MapController());
  SettingsCtrl settingsCtrl = Get.find<SettingsCtrl>();
  TextEditingController controller = TextEditingController();
@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: MyColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          MySharedPreferences.language == 'en' ? 'My location' : 'الموقع',
          style: const TextStyle(
            color: MyColors.primary,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
              FocusScope.of(context).unfocus();
            },

            child: const BackButton(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              // Get.back();
              MapController.find.currentLocation();
              print('hi');
              settingsCtrl.addressCtrl.text=controller.text;
              print(settingsCtrl.addressCtrl.text);
              // MapController.find.placeAutoComplete('usa');
              // MapController.find.updateLocationDetails(mapController, context);
            },
            backgroundColor: MyColors.blue14B,
            label: Text(
              'Confirm'.tr,
              style: const TextStyle(color: MyColors.white),
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: const Alignment(0, 0),
        children: [

          GoogleMap(
            // markers: markers.toSet(),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                (MySharedPreferences.lat != 0 && MySharedPreferences.lat.isFinite)
                    ? MySharedPreferences.lat
                    : (MapController.find.mapLat ?? 31.9539), // default Amman

                (MySharedPreferences.long != 0 && MySharedPreferences.long.isFinite)
                    ? MySharedPreferences.long
                    : (MapController.find.mapLng ?? 35.9106),
              ),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController googleMapController) {
              MapController.find.mapController = googleMapController;
            },
            // zoomControlsEnabled: false,
            // myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onTap: (LatLng lg) {
              mapController.currentLocation();
              mapController.markers.add(Marker(
                  markerId: const MarkerId('1'),
                  position: LatLng(lg.latitude, lg.longitude)));
            },
            onCameraMove: (CameraPosition position) {
              log("position:: ${position.target.latitude} -- ${position.target.longitude}");
              MapController.find.mapLat = position.target.latitude;
              MapController.find.mapLng = position.target.longitude;
              MySharedPreferences.lat = position.target.latitude;
              MySharedPreferences.long = position.target.longitude;
            },

          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(

                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  child: GooglePlaceAutoCompleteTextField(

                    language: MySharedPreferences.language,
                    placeType: PlaceType.address,
                    boxDecoration:  BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Border color
                          width: .50,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(15.0) //                 <--- border radius here
                        ),
                        color: MyColors.white),
                    textEditingController: controller,
                    googleAPIKey: "AIzaSyAnfh0DpOOyJ9Y9LUduYyqTnffqCJm0teU",
                    inputDecoration: InputDecoration(
                      hintText: "Search your location".tr,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    debounceTime: 400,
                    countries: ['jo'],
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (Prediction prediction) {
                      // print("placeDetails" + prediction.lat!);
                      // print("placeDetails" + prediction.lng.toString());
                      FocusScope.of(context).unfocus();

                      // print('in');
                      MapController.find.mapLat = double.parse(prediction.lat!);
                      MapController.find.mapLng = double.parse(prediction.lng!) ;
                      // print(' MapController.find.mapLat ${ MapController.find.mapLat}');
                      // print(' MapController.find.mapLng ${ MapController.find.mapLng}');
                      updateMapPosition(MapController.find.mapLat! ,MapController.find.mapLng!);

                      MySharedPreferences.lat = double.parse(prediction.lat!);
                      MySharedPreferences.long = double.parse(prediction.lng!);
                    },

                    itemClick: (Prediction prediction) {
                      FocusScope.of(context).unfocus(); // Dismiss keyboard on selection

                      controller.text = prediction.description ?? "";
                      FocusScope.of(context).unfocus(); // Dismiss keyboard on selection

                      print(prediction.description);
                      controller.selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: prediction.description?.length ?? 0));
                    },
                    seperatedBuilder: Divider(),
                    containerHorizontalPadding: 10,

                    // OPTIONAL// If you want to customize list view item builder
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                                child: Text(prediction.description ?? ""))
                          ],
                        ),
                      );
                    },

                    isCrossBtnShown: true,
                  ),
                ),
                const MyLocationButton(),
              ],
            ),
          ),
          const CustomMarker(color: MyColors.primary),
        ],
      ),
    );
  }
  void updateMapPosition(double newLatitude, double newLongitude) {
      MapController.find.mapController?.animateCamera(
        CameraUpdate.newLatLng(LatLng(newLatitude, newLongitude)),
      );

  }
}
