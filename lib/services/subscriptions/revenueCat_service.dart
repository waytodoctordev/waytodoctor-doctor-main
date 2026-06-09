import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../utils/shared_prefrences.dart';

class RevenueCatService  {
  static bool _configured = false;
  static bool _listenerAttached = false;
  static RxBool hasSub = false.obs;
  static List<Package>? packages;
  static late  CustomerInfo customerInfo;

  static Future<void> init() async {
    if (!_configured) {
      await configureRevenueCat();
      _configured = true;
    }

    // These should ALWAYS run
    await refreshCustomerInfo();
    if (!_listenerAttached) {
      listenToSubscriptionStatus();
      _listenerAttached = true;
    }
  }

  // ✅ Configure Rev Cat
  static Future<void> configureRevenueCat() async {
    await dotenv.load();
    try {
      // 🔥
      final configuration = PurchasesConfiguration(
        Platform.isIOS
            ? dotenv.env['RevenueCAT_PUBLIC_KEY_IOS']!
            : dotenv.env['RevenueCAT_PUBLIC_KEY_ANDROID']!,
      );

      await Purchases.configure(configuration);

    } catch (e) {
      throw Exception('error configuring of Revenue Cat $e');
    }
  }
  // ✅ UPDATING SUBSCRIPTION STATUS

  static void _updateSubscriptionStatus(
      CustomerInfo customerInfo,
      ) {
    hasSub.value =
        customerInfo.entitlements.active.containsKey('pro');

    MySharedPreferences.isSubscriped =
        hasSub.value;
  }
  // ✅ CHECKING USER PURCHASED STATUS
  static Future<void> refreshCustomerInfo() async {
    try {
      customerInfo = await Purchases.getCustomerInfo();
      _updateSubscriptionStatus(customerInfo);
    } catch (e) {
      print('Error refreshing customer info: $e');
    }
  }

  // ✅ FETCH OFFERINGS
  static Future<Offerings?> offerings() async {
    try {
      print('get offerings starting ');
      final offerings = await Purchases.getOfferings();
      print('get offerings ${offerings.all}');

      packages = offerings.current?.availablePackages;
      print('get offerings');

      return offerings;
    } catch (e) {
      throw Exception('error fetching offerings of Revenue Cat $e');
    }
  }

  // ✅ PURCHASE A PACKAGE
  static Future<PurchaseResult> purchasePackage(
      Package package) async {
    try {
      final result = await Purchases.purchase(
        PurchaseParams.package(package),
      );

      return PurchaseResult(
        success: true,
        customerInfo: result.customerInfo,
      );
    } on PlatformException catch (e) {
      final errorCode =
      PurchasesErrorHelper.getErrorCode(e);

      if (errorCode ==
          PurchasesErrorCode.purchaseCancelledError) {
        return PurchaseResult(
          success: false,
          cancelled: true,
          message: "Purchase cancelled",
        );
      }

      return PurchaseResult(
        success: false,
        message: e.message ?? "Purchase failed",
      );
    } catch (e) {
      return PurchaseResult(
        success: false,
        message: e.toString(),
      );
    }
  }


  // ✅ENSURING CONFIGURED USER
  static Future<void> ensureConfiguration() async {
    if (!_configured) {
      // 🔥
      await configureRevenueCat();
    }
    return;
  }

  // ✅ LISTEN TO SUBSCRIPTION STATUS
  static void listenToSubscriptionStatus() {
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      _updateSubscriptionStatus(customerInfo);
    });
  }

}
class PurchaseResult {
  final bool success;
  final bool cancelled;
  final String? message;
  final CustomerInfo? customerInfo;

  PurchaseResult({
    required this.success,
    this.cancelled = false,
    this.message,
    this.customerInfo,
  });
}