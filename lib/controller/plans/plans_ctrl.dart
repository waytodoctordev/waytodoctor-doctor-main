// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/copoun/copoun_api.dart';
import 'package:way_to_doctor_doctor/api/plans/plans_api.dart';
import 'package:way_to_doctor_doctor/binding/for_doctor/doctor_base_nav_bar_binding.dart';
import 'package:way_to_doctor_doctor/model/copoun_model/copun_model.dart';
import 'package:way_to_doctor_doctor/model/plans_model/plans_model.dart';
import 'package:way_to_doctor_doctor/ui/base/for_doctor/doctor_base_nav_bar.dart';
import 'package:way_to_doctor_doctor/ui/widgets/overlay_loader.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../binding/registration/specialization_binding.dart';
import '../../model/checkout_error_model.dart';
import '../../model/checkout_model.dart';
import '../../ui/screens/pay_screen/pay_screen.dart';
import '../../ui/screens/registration/specialization_certificate/specialization_certificate_screen.dart';
import '../../ui/screens/registration/specialization_certificate/widgets/specialization_certificate_end.dart';

class PlansCtrl extends GetxController {
  static PlansCtrl get find => Get.find();
  late PageController pageCtrl;
  int currentIndex = 0;
  double discount = 0.0;
  double price = 0.0;
  double actualPrice = 0.0;
  bool isCopounAdded = false;
  late List<Plan?> plans;
  PlansModel? plansModel;
  late Future<PlansModel?> initializePlansFuture;

  initPlans() {
    initializePlansFuture = fetchPlans();
    update();
  }

  int? isActive;
  Future<PlansModel?> fetchPlans() async {
   print('object fetch plans');
   plansModel = await PlansApi.plans();
   print(plansModel?.data);
   if (plansModel!.code == 200) {
     print('plansModel!.code == 200');

     plans = plansModel!.data!;
     isActive = plansModel!.data![0].isActive!;
     price = double.parse(plansModel!.data![0].price!);
     actualPrice = double.parse(plansModel!.data![0].price!);
     update();
     return plansModel;
   }
   return null;
  }

  String? couponType = 'fixed';
  String? discountType = 'percentage';
  CopounModel? copounModel;
  int couponId = 0;

  Future fetchCopoun(
      {required BuildContext context, required String copounName}) async {
    AppConstants.showLoading(context);
    copounModel = await CopounApi.data(copounName: copounName);
    if (copounModel == null) {
      AppConstants().showMsgToast(context, msg: 'Coupon not found'.tr);
      Loader.hide();
      return;
    }
    if (copounModel!.code == 200) {
      if (copounModel!.data.status == 1) {
        if (copounModel!.data.couponType == 'count') {
          if (copounModel!.data.count != 0) {
            log('message');
            discount = copounModel!.data.discount;
            discountType=copounModel!.data.discountType;
            couponType = copounModel!.data.couponType;
            Loader.hide();
            isCopounAdded = true;
            getPriceAfterDiscount(discount, copounModel!.data.id);
            update();
            AppConstants()
                .showMsgToast(context, msg: AppConstants.addedSuccessfully);
          } else {
            log('message2');
            isCopounAdded = false;
            Loader.hide();
            AppConstants().showMsgToast(context, msg: 'Coupon is invalid'.tr);
          }
        }
        if (copounModel!.data.couponType == 'date') {
          log((copounModel!.data.endDate.difference(DateTime.now()).inHours +
                  23)
              .toString());
          if (copounModel!.data.endDate.difference(DateTime.now()).inHours +
                  23 >=
              1) {
            log('message');
            discount = copounModel!.data.discount;
            discountType=copounModel!.data.discountType;
            couponType = copounModel!.data.couponType;
            Loader.hide();
            isCopounAdded = true;
            getPriceAfterDiscount(discount, copounModel!.data.id);
            update();
            AppConstants()
                .showMsgToast(context, msg: AppConstants.addedSuccessfully);
          } else {
            log('message2');
            isCopounAdded = false;
            Loader.hide();
            // AppConstants().showMsgToast(context, msg: 'Coupon is invalid'.tr);
            AppConstants().showMsgToast(context, msg: 'Coupon is invalid'.tr);
          }
        }
      } else if (copounModel!.data.status == 0) {
        AppConstants().showMsgToast(context, msg: 'Coupon is invalid'.tr);
        isCopounAdded = false;
        Loader.hide();
      }
      // return copounModel!;
    } else if (copounModel!.code == 500) {
      AppConstants().showMsgToast(context, msg: 'Coupon not found'.tr);
      Loader.hide();
    } else {
      // AppConstants().showMsgToast(context, msg: 'Coupon not found'.tr);
    }
  }

  getCurrentIndex(int index) {
    currentIndex = index;
    isCopounAdded = false;
    couponId = 0;
    update();
  }

  getCurrentPrice(double planPrice) {
    price = planPrice;
    actualPrice = planPrice;
    update();
  }

  getPriceAfterDiscount(double dis, int cId) {
    if (discountType == 'fixed') {
      price = price - discount;
    } else if (discountType == 'percentage') {
      price = price - (price * dis / 100);
      price.toStringAsFixed(2);
    }
    couponId = cId;
    isCopounAdded = true;
    log('Price After discount :: $price');
    log('Coupon Id :: $couponId');
    // print(isCopounAdded);
    update();
  }

  getPriceWithoutDiscount() {
    // currentIndex = index;
    couponId = 0;
    price = actualPrice;
    price.toStringAsFixed(2);
    isCopounAdded = false;
    log('Coupon Id :: $couponId');
    update();
  }

  @override
  void onInit() {
    initPlans();
    pageCtrl = PageController(initialPage: currentIndex);
    super.onInit();
  }

  @override
  void onClose() {
    pageCtrl.dispose();
    super.onClose();
  }
// userid-planid-createat-endat
  // String orderNumber =
  //     'order-${MySharedPreferences.userId}-${DateTime.now().year}-${DateTime.now().month}';

  // static const orderCurrency = "USD";
  // static const orderDescription = "Way To doctor";
  // static const merchantPass = "b6984e6867e341275cb631ca4561f42c";
  // static const link = 'https://checkout.montypay.com/api/v1/session';
  // static const merchantKey = "4d759bf8-8cf0-11ed-bc0a-66be8322d928";
  // String? payUrl;

  Future checkout({
    required String planId,
    required String amount,
    required int daysOfPlan,
    required BuildContext context,
  }) async {

    OverLayLoader.showLoading(context);
    String orderAmount = amount ;
    String orderNumber =
        '${MySharedPreferences.userId}_${planId}_${DateTime.now().toString().split(' ').first}_${DateTime.now().add(Duration(days: daysOfPlan)).toString().split(' ')[0]}_$couponId';

    final inputString =
        '$orderNumber$orderAmount${AppConstants.orderCurrency}${AppConstants.orderDescription}${AppConstants.merchantPass}';
    // '$orderNumber$orderAmount${AppConstants.orderCurrency}${AppConstants.orderDescription}${AppConstants.merchantPassDemo}';
    final utf8Bytes = utf8.encode(inputString.toUpperCase());
    final md = md5.convert(utf8Bytes);
    var hash = sha1.convert(utf8.encode(md.toString()));
    log(hash.toString());

    try {
      String url = AppConstants.checkoutUrl;
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        // "merchant_key": AppConstants.merchantKeyDemo,
        "merchant_key": AppConstants.merchantKey,
        "operation": "purchase",
        "methods": ["card"],
        "order": {
          "number": orderNumber,
          "amount": orderAmount,
          "currency": AppConstants.orderCurrency,
          "description": AppConstants.orderDescription
        },
        "cancel_url": "https://example.com/cancel",
        "success_url": "https://www.facebook.com/m0ustafamahm0ud",
        // "customer": {
        //   // "name": name,
        //   // "email": 'm0ustafamahm0ud@yahoo.com'
        // },
        "billing_address": {"phone": MySharedPreferences.userNumber},
        "recurring_init": "true",
        "hash": hash.toString()
      });
      // log("Response:: CheckoutResponse\nUrl:: $url\nheaders:: ${headers.toString()}");
      http.Response response =
          await http.post(uri, headers: headers, body: body);
      // log("CheckoutStatusCode:: ${response.statusCode} CheckoutBody:: ${response.body}");
      if (response.statusCode == 200) {
        // log('${orderNumber}aaaaaa');
        CheckoutDoneModel checkoutDoneModel =
            CheckoutDoneModel.fromJson(json.decode(response.body));
        Loader.hide();
        Get.to(() => PayScreenMontyPay(
                  payUrl: checkoutDoneModel.redirectUrl,
                  planId: planId,
                  copounId: couponId,
                  daysOfPlan: daysOfPlan,
                ),);
        //     .whenComplete(() async {
        //  if( MySharedPreferences.isSubscriped){
        //    Get.to(const SpecializationScreen(),binding: SpecializationBinding());
        //  }
        //
        //   // await PaymentCtrl.find.getSubscriptionInfo(
        //   //     token: MySharedPreferences.accessToken,
        //   //     context: context,
        //   //     subId:
        //   //         '${MySharedPreferences.userId}_${planId}_${DateTime.now().toString().split(' ').first}_${DateTime.now().add(Duration(days: daysOfPlan)).toString().split(' ')[0]}_$couponId');
        // });
        return response;
      } else {
        CheckoutErrorModel checkoutErrorModel =
            CheckoutErrorModel.fromJson(json.decode(response.body));
        Loader.hide();
        log(checkoutErrorModel.errors[0].errorMessage);
        return null;
      }
    } catch (e) {
      log("$e");
      return null;
    }
  }
}
