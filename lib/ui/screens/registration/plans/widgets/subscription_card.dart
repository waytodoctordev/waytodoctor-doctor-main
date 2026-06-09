import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:way_to_doctor_doctor/controller/for_center/center_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/base/for_center/center_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/screens/registration/plans/widgets/subscription_end.dart';
import 'package:way_to_doctor_doctor/ui/screens/subscription_details/subscription_screen.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import '../../../../../controller/registration/sign_in_ctrl.dart';
import '../../../../../services/subscriptions/revenueCat_service.dart';
import '../../../../../utils/general_methods.dart';
import '../../../../../utils/shared_prefrences.dart';
import '../../../../base/for_doctor/doctor_base_nav_bar.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Get.height*.03),
      padding: const EdgeInsets.only(right: 0, left: 0, top: 20),
      decoration: BoxDecoration(
        color: MyColors.blue14B,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subscriptionName.tr,
            style: const TextStyle(
              fontSize: 20,
              color: MyColors.white,
            ),
          ),
          const Spacer(),
          Material(
            color: Colors.transparent,
            child: RichText(
              textAlign: TextAlign.center,
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
                    text: '$subscriptionPrice \n  ',
                    style: GoogleFonts.tajawal(
                      fontSize: 35,
                      color: MyColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  TextSpan(
                    text: '\n Connect with patients worldwide.'.tr,
                    style: GoogleFonts.tajawal(
                      fontSize: 15,
                      color: MyColors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
              title: 'subscription'.tr,
              width: double.maxFinite,
              color: const Color(0xFF14B9D1),
              onPressed: () async {

                final result =
                await RevenueCatService.purchasePackage(
                  RevenueCatService.packages![0],
                );

                if (result.success) {
                  RevenueCatService.refreshCustomerInfo();
                  Get.snackbar(
                    "Success",
                    "Subscription activated",
                  );
                } else if (result.cancelled) {
                  Get.snackbar(
                    "Cancelled",
                    "Purchase cancelled",
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    result.message ?? "Purchase failed",
                  );
                }

              }),
          // CustomElevatedButton(
          //     title: 'subscription'.tr,
          //     width: double.maxFinite,
          //     color: const Color(0xFF14B9D1),
          //     onPressed: () async {
          //       try {
          //         final customerInfo = await RevenueCatService.purchasePackage(
          //           RevenueCatService.packages![0],
          //         );
          //         if (customerInfo != null) {
          //           RevenueCatService.updateSubscription(customerInfo);
          //         }
          //
          //         if( RevenueCatService.hasSub.value){
          //           print('RevenueCatService.hasSub.value ${RevenueCatService.hasSub.value}');
          //         if(  MySharedPreferences.reNewSub ){
          //           print('MySharedPreferences.reNewSub ${MySharedPreferences.reNewSub}');
          //           print('MySharedPreferences.isDoctor ${MySharedPreferences.isDoctor}');
          //
          //           MySharedPreferences.isDoctor
          //               ? Get.offAll(() => const DoctorBaseNavBar())
          //               : Get.offAll(() => const CenterBaseNavBar());
          //         }else{
          //           Get.offAll(() => const SubscriptionEnd());
          //         }
          //
          //
          //         }else{
          //           print('RevenueCatService.hasSub.value ${RevenueCatService.hasSub.value}');
          //
          //           Get.to(() => const SubscriptionScreen());
          //         }
          //
          //       } on PlatformException catch (error) {
          //         if (error.details['readable_error_code'] ==
          //             "PURCHASE_CANCELLED") {
          //           // Get.back();
          //           showDialog(
          //             context: context,
          //             builder: (context) => AlertDialog(
          //               title: Text('Confirm Subscription Cancellation'.tr),
          //               content: Text(
          //                   'Are you sure you want to cancel your subscription?'
          //                       .tr),
          //               actions: [
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment
          //                       .center, // Aligns buttons evenly
          //                   children: [
          //                     SizedBox(
          //                       width: Get.width * .4,
          //                       child: CustomElevatedButton(
          //                         title: 'Yes, I\'m sure',
          //                         onPressed: () {
          //                           openIOSSubscriptionSettings();
          //                           Purchases.logOut();
          //                           Get.back();
          //                         },
          //                       ),
          //                     ),
          //                     SizedBox(
          //                       width: 4,
          //                     ),
          //                     SizedBox(
          //                       width: Get.width * .24,
          //                       child: CustomElevatedButton(
          //                         title: 'Cancel',
          //                         onPressed: () {
          //                           Get.back();
          //                         },
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ],
          //             ),
          //           );
          //           // Handle this case as a dismissed action
          //         } else {
          //           showDialog(
          //             context: context,
          //             builder: (context) => AlertDialog(
          //               title: Text('Warning: you have '.tr),
          //               content:
          //                   Text('Something went Wrong, try again later'.tr),
          //               actions: [
          //                 SizedBox(
          //                   child: CustomElevatedButton(
          //                     title: 'Ok',
          //                     onPressed: () {
          //                       Get.back();
          //                     },
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           );
          //         }
          //         // subscriptionNotifier.resetIosPaymentLoading();
          //         // MySharedPreferences.lastScreen = '';
          //         // log('error.message  ${error.message}?? ' '');
          //         // Purchases.logOut();
          //       }
          //     }),
        ],
      ),
    );
  }
}

void openIOSSubscriptionSettings() {
  final url = 'https://apps.apple.com/account/subscriptions';
  launchUrl(Uri.parse(url));
}
