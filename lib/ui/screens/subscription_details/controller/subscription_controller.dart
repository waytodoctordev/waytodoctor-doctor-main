import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  static SubscriptionController get find => Get.find();

  late PageController pageCtrl;
  RxInt currentIndex = 0.obs;
  double discount = 0.0;
  double price = 0.0;
  double actualPrice = 0.0;



  int? isActive;



  getCurrentIndex(int index) {
    currentIndex.value = index;
    update();
  }

  getCurrentPrice(double planPrice) {
    price = planPrice;
    actualPrice = planPrice;
    update();
  }


  @override
  void onInit() {
    pageCtrl = PageController(initialPage: currentIndex.value);
    super.onInit();
  }

  @override
  void onClose() {
    pageCtrl.dispose();
    super.onClose();
  }


}
