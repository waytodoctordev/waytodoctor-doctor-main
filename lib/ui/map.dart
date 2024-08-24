import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:way_to_doctor_doctor/controller/map.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_marker.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_text_field.dart';
import 'package:way_to_doctor_doctor/ui/widgets/my_location_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class MapScreen extends StatelessWidget {
  // final GoogleMapController mapController;

   MapScreen({
    super.key,
    // required this.mapController,
  });
MapController mapController =Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            },
            child: const BackButton(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.back();

              // MapController.find.updateLocationDetails(mapController, context);
            },
            backgroundColor: MyColors.blue14B,
            label: Text(
              'Confirm'.tr,
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: const Alignment(0, 0),
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController googleMapController) {
              MapController.find.mapController = googleMapController;
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                MySharedPreferences.lat == 0 ? MapController.find.mapLat! : MySharedPreferences.lat,
                MySharedPreferences.long == 0 ? MapController.find.mapLng! : MySharedPreferences.long,
              ),
              zoom: 15,
            ),
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomTextField(
                    readOnly: true,
                    filled: true,
                    fillColor: Colors.white,
                    onTap: () {
                      // MapController.find.showSearchField(context);
                    },
                    label: 'Start Searching'.tr,
                    prefixIcon: const Icon(Icons.search),
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
}
