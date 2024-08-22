import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/models/store_product_wrapper.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../api/purchases/purchase_request_api.dart';
import '../model/purchase_model/purchase_model.dart';
import '../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../utils/shared_prefrences.dart';

class InAppPurchaseController extends GetxController {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  // Indicates if the store is available.
  final RxBool isAvailable = false.obs;

  // Indicates if a purchase is pending.
  final RxBool isPending = false.obs;
  final RxBool isPurchased = false.obs;
  final RxInt planId = 6.obs;

  /// List of available product details.
  final RxList<ProductDetails> products = <ProductDetails>[].obs;

  /// List of purchase details.
  final RxList<PurchaseDetails> purchases = <PurchaseDetails>[].obs;

  /// Stores error messages.
  final RxString errorMessage = ''.obs;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    // _subscription = _inAppPurchase.purchaseStream.listen(
    //   _onPurchaseUpdated,
    //   onDone: () => _subscription?.cancel(),
    //   onError: (error) => errorMessage.value = error.toString(),
    // );
    // initStoreInfo();
  }

  /// Initializes the store information and queries available products.
  Future<void> initStoreInfo() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      isAvailable.value = false;
      errorMessage.value = 'The store is unavailable';
      return;
    }

    if (Platform.isIOS) {
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(PaymentQueueDelegate());
    }

    const Set<String> kIds = <String>{
      'Premium_Annual_Subscription',
      'Premium_Monthly_Subscription',
    };
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(kIds);
    if (response.error != null) {
      errorMessage.value = response.error?.message ?? '';
    } else {
      products.value = response.productDetails;
    }
    restorePurchases();
    isAvailable.value = available;
    print('_subscription');
    print(' isAvailable.value ${ isAvailable.value}');

    isAvailable.value = available;

  }

  /// Handles purchase updates from the purchase stream.
  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    print('inside ');
    purchases.addAll(purchaseDetailsList);
    print('purchaseDetailsList purchases ${purchases.length}');
    for (var purchase in purchaseDetailsList) {
      print('for');
      print('${purchaseDetailsList[0].status}');
      print('${purchaseDetailsList[0].transactionDate}');
      print('${purchaseDetailsList[0].pendingCompletePurchase}');
      print('${purchaseDetailsList[0].productID}');
      print('${purchaseDetailsList[0].purchaseID}');
      switch (purchase.status) {
        case PurchaseStatus.pending:
          debugPrint(' purchase is in pending  ${purchase.status}');
          break;
        case PurchaseStatus.error:
          print('switch error ');
          errorMessage.value = purchase.error?.message ?? '';
          break;
        case PurchaseStatus.canceled:
          print('switch canceled ');
          _cancelPurchases();
          break;
        case PurchaseStatus.purchased:
          debugPrint("PurchaseStatus.purchased");
          _verifyPurchase(purchase);
          debugPrint("_verifyPurchase");
          debugPrint("DoctorBaseNavBar");
          break;
        case PurchaseStatus.restored:
          print('restored purchases');
          _verifyRestore(purchase);
          break;
      }
    }
  }

  /// Restores previous purchases.
  Future<void> restorePurchases() async {
    print('restore purchases method');
    await InAppPurchase.instance.restorePurchases();
    await Future.delayed(const Duration(seconds: 30));
    print('restore purchases wait');

  }

  void _cancelPurchases() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                      const SizedBox(height: 15),
                      Text(
                        "Your subscription has been successfully canceled. Thank you for being with us"
                            .tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFFFFFFFF),
                                minimumSize: const Size(0, 45),
                                backgroundColor: const Color(0xFF14B9D1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'OK'.tr,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Verifies restored purchases.   server-side verification here.
  Future<void> _verifyRestore(PurchaseDetails purchaseDetails) async {
    // Implement server-side verification for restoring purchases

    debugPrint("_verifyRestore: ${purchaseDetails.productID}");
    await _inAppPurchase.restorePurchases();
  }

  /// Verifies completed purchases. server-side verification here.
  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    print('_verifyPurchase method ');
    if (purchaseDetails is AppStorePurchaseDetails) {
      print('AppStorePurchaseDetails if statement');
      SKPaymentTransactionWrapper skProduct =
          (purchaseDetails).skPaymentTransaction;
      print(skProduct.payment);
      print(skProduct.transactionIdentifier);
    }

    try {
      if (purchaseDetails.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchaseDetails);
        MySharedPreferences.isSubscriped =true;
        Get.to(() => const DoctorBaseNavBar(),binding: DoctorBaseNavBarBinding());

        print('_verifyPurchase if else statement');
        print('_verifyPurchase completePurchase ');
        // print('dateFormatted $dateFormatted');
        print('MySharedPreferences.userId ${MySharedPreferences.userId}');
        print('planId $planId');
        // var dateFormatted = DateFormat("yyyy-MM-dd").format(DateTime.now());
        // String verificationData =
        //     purchaseDetails.verificationData.serverVerificationData;
        // String base64Receipt = base64Encode(verificationData.codeUnits);
        // String base64Receipt = base64Encode(utf8.encode(verificationData));

        // String? verificationData = purchaseDetails.transactionDate;
        // print('verificationData $verificationData');
        // print('base64Receipt  what $base64Receipt');

// Implement server-side verification for real purchases

        // PurchasesModel? purchasesModel = await PurchaseRequestApi.data(
        //   startDate: dateFormatted,
        //   receipt: verificationData,
        //   userId: '${MySharedPreferences.userId}',
        //   planId: '${planId.value}',
        // );
        // print('purchasesModel!.code=${purchasesModel?.code}');
        // purchasesModel!.code == 200 //Get.to(() => const DoctorBaseNavBar())
        //     ? print('purchasesModel!.code navigate to HOMEPAGE ${purchasesModel.code}')
        //     : print('purchasesModel!.code  error navigate to HOMEPAGE${purchasesModel.code}');// Scaffold(body: Text('error'),);
      }
    } catch (e) {
      print('nancy $e');
    }
  }

  /// Initiates the purchase process for a subscription.
  Future<void> buySubscription(ProductDetails productDetails) async {
    try {
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: productDetails);
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
    } on Exception catch (e) {
      errorMessage.value = e.toString();
      debugPrint('Failed to purchase: $e');
    }
  }

  // Cancel the subscription and dispose of the store delegate
  @override
  void onClose() {
    // _subscription?.cancel();
    disposeStore();
    super.onClose();
  }

  /// Disposes of the store delegate for iOS.
  Future<void> disposeStore() async {
    if (Platform.isIOS) {
      final iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(null);
    }
  }
}

/// A delegate class for handling iOS-specific purchase queue events.
class PaymentQueueDelegate extends SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    // Allow the transaction to continue
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    // Do not show the price consent dialog
    return false;
  }
}
