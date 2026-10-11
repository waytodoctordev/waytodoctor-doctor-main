import 'dart:async';
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
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = Get.put(MapController());
  SettingsCtrl settingsCtrl = Get.put(SettingsCtrl());
  TextEditingController tController = TextEditingController();
  final Completer<GoogleMapController> _gmController =
  Completer<GoogleMapController>();

  List<Marker> markers =  [];

  @override
  void initState() {
    super.initState();
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(MapController.find.mapLat,
        MapController.find.mapLng),
    zoom: 15,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );



  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      builder: (controller) => Scaffold(
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
            padding: EdgeInsets.symmetric(vertical: Get.width * .150),
            child: SizedBox(
              width: Get.width * .7,
              child: FloatingActionButton.extended(
                onPressed: () async{

               // await   controller.currentLocation();
               updateMapPosition(
                 controller.mapLat,
                 controller.mapLng,
               );
                  print('hi ${controller.mapLat} ${controller.mapLng }');
                  settingsCtrl.addressCtrl.text = tController.text;
                  print(settingsCtrl.addressCtrl.text);
                  updateMapPosition(
                      MapController.find.mapLat, MapController.find.mapLng);
                 },
                backgroundColor: MyColors.blue14B,
                label: Text(
                  'Confirm'.tr,
                  style: const TextStyle(color: MyColors.white, fontSize: 18),
                ),

              ),
            ),
          ),
          body: SafeArea(
            child: Stack(
              alignment: const Alignment(0, 0),
              children: [
                GoogleMap(
                markers: controller.markers.toSet(),
                markerType: GoogleMapMarkerType.advancedMarker,
                mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _gmController.complete(controller);
                    mapController.mapController = controller;

                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: GooglePlaceAutoCompleteTextField(
                          language: MySharedPreferences.language,
                          placeType: PlaceType.address,
                          boxDecoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: .50,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                      15.0) //                 <--- border radius here
                                  ),
                              color: MyColors.white),
                          textEditingController: tController,
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
                            final lat = double.parse(prediction.lat!);
                            final lng = double.parse(prediction.lng!);

                            MapController.find.moveToLocation(lat, lng);

                            MySharedPreferences.lat = lat;
                            MySharedPreferences.long = lng;
                          },

                          itemClick: (Prediction prediction) {
                            FocusScope.of(context)
                                .unfocus(); // Dismiss keyboard on selection

                            tController.text = prediction.description ?? "";
                            FocusScope.of(context)
                                .unfocus(); // Dismiss keyboard on selection

                            print(prediction.description);
                            tController.selection = TextSelection.fromPosition(
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
          ),
        ));
  }

  void updateMapPosition(double newLatitude, double newLongitude) {
    MapController.find.mapController?.animateCamera(
      CameraUpdate.newLatLng(LatLng(newLatitude, newLongitude)),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _gmController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}
