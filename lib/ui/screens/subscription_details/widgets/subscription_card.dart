import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../services/subscriptions/revenueCat_service.dart';
import '../../../../utils/colors.dart';
import '../../../widgets/custom_elevated_button.dart';

class SubscriptionCard extends StatelessWidget {
  final String subscriptionId;
  final String subscriptionName;
  final String subscriptionPrice;
  final String subscriptionDescription;
  const SubscriptionCard({
    super.key,
    required this.subscriptionId,
    required this.subscriptionName,
    required this.subscriptionPrice,
    required this.subscriptionDescription,
  });

  @override
  Widget build(BuildContext context) {
    String price = subscriptionPrice
        .replaceAll(RegExp(r'[^0-9.]'), '')
        .substring(0,
        subscriptionPrice.replaceAll(RegExp(r'[^0-9.]'), '').length.clamp(0, 4)
    );
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 37),
      padding: const EdgeInsets.only(right: 0, left: 0, top: 20),
      decoration: BoxDecoration(
        color: MyColors.blue14B,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            subscriptionName.tr,
            style: const TextStyle(
              fontSize: 14,
              color: MyColors.white,
            ),
          ),
           SizedBox(height: Get.height*.1),
         RichText(
           textAlign:TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: r'$',
                    style: GoogleFonts.tajawal(
                      fontSize: 25,
                      color: MyColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: price,
                    style: GoogleFonts.tajawal(
                      fontSize: 35,
                      color: MyColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: '/ $subscriptionDescription\n ',
                    style: GoogleFonts.tajawal(
                      fontSize: 10,
                      color: MyColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: '\n Connect with Doctors worldwide.'.tr,
                    style: GoogleFonts.tajawal(
                      fontSize: 15,
                      color: MyColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

          // const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: CustomElevatedButton(
                title: 'subscription'.tr,
                width: double.maxFinite,
                color: const Color(0xFF14B9D1),
                onPressed: () async {
                  final customerInfo = await RevenueCatService.purchasePackage(
                    RevenueCatService.packages![0],
                  );
                  if (customerInfo.success) {
                    await RevenueCatService.refreshCustomerInfo();
                  }
                }),

         ),
        ],
      ),
    );
  }
}

void openIOSSubscriptionSettings() {
  final url = 'https://apps.apple.com/account/subscriptions';
  launchUrl(Uri.parse(url));
}
