import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:slide_action/slide_action.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/icons.dart';
import '../../../../widgets/custom_slider_button.dart';

class AddressComponent extends StatelessWidget {
  final double lat;
  final double long;

  AddressComponent({
    super.key,
    required this.lat,
    required this.long,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address :'.tr,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 18,
            color: MyColors.blue14B,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SlideAction(
            trackBuilder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                      'Address'.tr
                  ),
                ),
              );
            },
            thumbBuilder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: MyColors.blue14B,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                  ),
                ),
              );
            },
            action: () async {
              final String googleMapslocationUrl =
                  "https://www.google.com/maps/search/?api=1&query=$lat,$long";
              final String encodedURl = Uri.encodeFull(googleMapslocationUrl);
              await launchUrl(
                Uri.parse(encodedURl),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ),
      ],
    );
  }
}
