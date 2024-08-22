import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:way_to_doctor_doctor/ui/widgets/custom_elevated_button.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import '../../../../../api/registration/doctor_login_api.dart';
import '../../../../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../../../../model/doctor_login/doctor_login_model.dart';
import '../../../../../utils/shared_prefrences.dart';
import '../../../../base/for_doctor/doctor_base_nav_bar.dart';

class SubscriptionCard extends StatelessWidget {
  // final String content;
  // final String price;
  // final Future<void> onPressed;
  // final String planId;
  // final int daysOfPlan;
  final String subscriptionId;
  final String subscriptionName;
  final String subscriptionPrice;
  const SubscriptionCard({
    super.key,
    required this.subscriptionId,
    required this.subscriptionName,
    required this.subscriptionPrice,
    // required this.content,
    // required this.price,
    // required this.onPressed
    // required this.planId,
    // required this.daysOfPlan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 37),
      padding: const EdgeInsets.only(right: 0, left: 0, top: 20),
      decoration: BoxDecoration(
        color: MyColors.blue14B,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subscriptionName.tr,
            style: const TextStyle(
              fontSize: 14,
              color: MyColors.white,
            ),
          ),
          const Spacer(),
          Material(
            color: Colors.transparent,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: r'$',
                    style: GoogleFonts.tajawal(
                      fontSize: 18,
                      color: MyColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: subscriptionPrice,
                    style: GoogleFonts.tajawal(
                      fontSize: 52,
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
                bool canMakePayments = await Purchases.canMakePayments();
                print('MySharedPreferences.step ${MySharedPreferences.step}');

                /// if canMakePayments == true => payment
                ///else show error message
                print(canMakePayments);
                try {
                  LogInResult login = await Purchases.logIn(
                      MySharedPreferences.userId.toString());
                  print(login.customerInfo);
                  print(login.created);
                  await Purchases.setAttributes({
                    'User ID': MySharedPreferences.userId.toString() ?? '',
                  });
                  CustomerInfo customerInfo = await Purchases.getCustomerInfo();
                  print('customerInfo $customerInfo');
                  print('customerInfo ${customerInfo}');
                  print('customerInfo $customerInfo');
                  List<StoreProduct> products =
                      await Purchases.getProducts(['Premium Access.']);
                  log('products =${products.toString()}');
                  log('subscriptionId =${subscriptionId.toString()}');
                  log('subscriptionId =$subscriptionName');
                  log('subscriptionId =$subscriptionPrice');

                  // StoreProduct productToPurchase = products.firstWhere((product) =>
                  // product.identifier ==
                  // 'Premium_Annual_Subscription');
                  await Purchases.purchaseProduct(
                    subscriptionId,
                    type: PurchaseType.subs,
                  );
                  log('productToPurchase =$subscriptionId');
                  // bool? isActive = customerInfo.entitlements.all[subscriptionId]?.isActive;
                  bool? isActive = customerInfo.entitlements.active.isNotEmpty;

                  log('isActive =$isActive');
                  DoctorLoginModel? doctorLoginModel = await DoctorLoginApi()
                      .data(
                          phone: MySharedPreferences.userNumber,
                          password: MySharedPreferences.password);
                  // isActive==true?MySharedPreferences.isSubscriped=true:MySharedPreferences.isSubscriped=false;
                  print(
                      'doctorLoginModel!.data!.doctorLoginData!.isSubscribed ${doctorLoginModel!.data!.doctorLogindata!.isSubscribed}');

                  doctorLoginModel.data!.doctorLogindata!.isSubscribed!
                      ? Get.offAll(() => const DoctorBaseNavBar(),
                          binding: DoctorBaseNavBarBinding())
                      : showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Warning: you have '.tr),
                            content: Text(
                                'Something went Wrong, try again later'.tr),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('Ok'.tr),
                              ),
                            ],
                          ),
                        );
                  MySharedPreferences.lastScreen = 'DoctorBaseNavBar';

                  // Purchases.addCustomerInfoUpdateListener((info) {
                  //   // handle any changes to customerInfo
                  // });

                  // Purchases.purchaseProduct('Premium_Annual_Subscription');
                  // StoreProduct roductToPurchase = products.firstWhere((product) =>
                  // product.identifier == 'Premium_Monthly_Subscription');
                  // controller.buySubscription(product);
                  // debugPrint("Get.to(() => const DoctorBaseNavBar());");
                  // debugPrint("controller.isPurchased.value nanosa${controller.isPurchased.value}");
                  // controller.buySubscription(controller
                  //     .products[0]);
                  // if (controller.isActive == 1) {
                  //   controller.checkout(
                  //       planId: planId,
                  //       context: context,
                  //       amount: controller.price.toStringAsFixed(2),
                  //       daysOfPlan: daysOfPlan);
                  // } else if (controller.isActive == 0) {
                  //   AppConstants().showMsgToast(context, msg: 'Currently unavailable'.tr);
                  // }
                } on PlatformException catch (error) {
                  // subscriptionNotifier.resetIosPaymentLoading();
                  MySharedPreferences.lastScreen = '';

                  log(error.message ?? '');
                  Purchases.logOut();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Warning: you have '.tr),
                      content: Text(
                          'Something went Wrong, try again later'.tr),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the dialog
                          },
                          child: Text('Ok'.tr),
                        ),
                      ],
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
