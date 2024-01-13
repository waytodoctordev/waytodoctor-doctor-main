import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/ui/screens/for_center/screens/center_home_screen.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../api/for_doctor/current_plan/current_plan_api.dart';
import '../../api/plans/plans_api.dart';
import '../../api/transaction_status_api.dart';
import '../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../model/subscription_model/subscription_model.dart';
import '../../model/transaction_model.dart';
import '../../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../../ui/screens/registration/plans/plans_screen.dart';
import '../../ui/screens/registration/plans/widgets/subscription_end.dart';
import '../../ui/widgets/overlay_loader.dart';
import '../../utils/shared_prefrences.dart';
import '../form/form_ctrl.dart';

class PaymentCtrl extends GetxController {
  static PaymentCtrl get find => Get.find();

  late WebViewController webViewController;
  bool isUrlLoaded = false;

  initWebView(String payUrl, BuildContext context, String planId,
      int daysOfPlan, int couponId) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            // log(url);
          },
          onPageFinished: (String url) {
            // log(url);
            Future.delayed(
              const Duration(seconds: 5),
              () {
                isUrlLoaded = true;
                update();
              },
            );
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            /// user subscription canceled
            if (request.url.contains('https://example.com/cancel')) {
              log('https://example.com/cancel');
              Get.back();
              // return NavigationDecision.prevent;
            }
            /// user payment paid
            if (request.url
                .contains('https://www.facebook.com/m0ustafamahm0ud')) {
              isPaymentEnded = true;
              update();
              Future.delayed(
                const Duration(seconds: 5),
                () async {
                  await getTransactionStatus(
                    orderNumber:
                        '${MySharedPreferences.userId}_${planId}_${DateTime.now().toString()
                            .split(' ').first}_${DateTime.now().add(Duration(days: daysOfPlan)).toString()
                            .split(' ')[0]}_$couponId',
                    context: context,
                    planId: planId,
                    daysOfPlan: daysOfPlan,
                  );
                },
              );
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(payUrl));
    super.onInit();
  }

  SubscriptionModel? subscriptionModel;

  // Future getSubscriptionInfo({
  //   required String token,
  //   required BuildContext context,
  //   required String subId,
  // }) async {
  //   AppConstants.showLoading(context);
  //   subscriptionModel = await CurrentPlanApi.getCurrentplan(subId: subId);
  //   if (subscriptionModel == null) {
  //     Loader.hide();
  //
  //     return;
  //   }
  //   if (subscriptionModel!.code == 200) {
  //     log(subscriptionModel!.data.orderNumber);
  //     if (MySharedPreferences.lastScreen == 'DoctorBaseNavBar') {
  //     AppConstants().showMsgToast(context, msg: 'Your subscription has been successfully renewed'.tr);
  //       MySharedPreferences.formCurrentIndex = 0;
  //       MySharedPreferences.subscriptionId = subId;
  //       MySharedPreferences.isSubscriped = true;
  //       MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
  //       Get.offAll(() => const DoctorBaseNavBar(),
  //           binding: DoctorBaseNavBarBinding());
  //     } else {
  //       await FormCtrl.find.updateUserData(dataBody: {
  //         'step': '1',
  //       }, context: context).whenComplete(
  //         () {
  //           MySharedPreferences.formCurrentIndex = 0;
  //           AppConstants().showMsgToast(context,
  //                   msg: 'You have make subscription successfully'.tr);
  //         },
  //       );
  //       MySharedPreferences.lastScreen = 'SubscriptionEnd';
  //       MySharedPreferences.subscriptionId = subId;
  //       MySharedPreferences.isSubscriped = true;
  //       Get.offAll(() => const SubscriptionEnd());
  //     }
  //     Loader.hide();
  //   } else if (subscriptionModel!.code == 500) {
  //     AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
  //     Loader.hide();
  //   }
  //   Loader.hide();
  // }

  SubscriptionModel? subscriptionModelforclinic;
  Future createSubscription({
    required String startDate,
    required String endDate,
    required String planId,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    subscriptionModel = await PlansApi.createSubscription(
        startDate: startDate, endDate: endDate, planId: planId);
    subscriptionModelforclinic = await PlansApi.createSubscriptionforclinic(
        startDate: startDate, endDate: endDate, planId: planId);
    if (subscriptionModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (subscriptionModel!.code == 200) {
            Get.offAll(() => const SubscriptionEnd());
      // 4475 2235 0488 9847
      // 1/26
      // 611
      // ALA ALBAWANEH
      /// MySharedPreferences.subscriptionId > 0 doctor already completed personal info
      // if (int.parse(MySharedPreferences.subscriptionId) > 0) {
      //   print('MySharedPreferences.subscriptionId) > 0');
      //  AppConstants().showMsgToast(context, msg: 'Your subscription has been successfully renewed'.tr);
      //   MySharedPreferences.formCurrentIndex = 0;
      //   MySharedPreferences.subscriptionId =
      //       subscriptionModel!.data.id as String;
      //   MySharedPreferences.isSubscriped = true;
      //   MySharedPreferences.lastScreen = 'DoctorBaseNavBar';
      //
      }  /// doctor registered for the first time
      // else {
      //   print('MySharedPreferences.subscriptionId) > else');
      //   await FormCtrl.find.updateUserData(dataBody: {
      //     'step': '1',
      //   }, context: context).whenComplete(
      //     () {
      //       MySharedPreferences.formCurrentIndex = 0;
      //       AppConstants().showMsgToast(context,
      //               msg: 'You have make subscription successfully'.tr);
      //       MySharedPreferences.lastScreen = 'SubscriptionEnd';
      //       MySharedPreferences.subscriptionId =
      //           subscriptionModel!.data.id as String;
      //       MySharedPreferences.isSubscriped = true;
      //       Get.offAll(() => const SubscriptionEnd());
      //     },
      //   );
      // }
    else if (subscriptionModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    } else {
      AppConstants().showMsgToast(context, msg: subscriptionModel!.msg);
    }
    Loader.hide();
  }

  bool isPaymentEnded = false;
  String status = '';
  TransactionModel? transactionModel;

  Future getTransactionStatus(
      {required String orderNumber,
      required BuildContext context,
      required String planId,
      required int daysOfPlan}) async {
    OverLayLoader.showLoading(context);
    transactionModel =
        await TransactionStatusApi.data(orderNumber: orderNumber);
    if (transactionModel == null) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Get.offAll(const PlansScreen());
      Loader.hide();
      return;
    }
    if (transactionModel!.code == 200) {
      status = transactionModel!.data.status;
      update();
      if (transactionModel!.data.status == 'success') {
        await createSubscription(
            startDate: DateTime.now().toString().split(' ')[0],
            endDate: DateTime.now()
                .add(Duration(days: daysOfPlan))
                .toString()
                .split(' ')[0],
            planId: planId,
            context: context);
      }
      if (transactionModel!.data.status == 'fail') {
        AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
        Get.offAll(const PlansScreen());
      }
    } else if (transactionModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
      Get.offAll(const PlansScreen());
    } else {
      AppConstants().showMsgToast(context, msg: transactionModel!.msg);
      Get.offAll(const PlansScreen());
    }
    Loader.hide();
  }
}
