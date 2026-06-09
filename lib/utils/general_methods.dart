import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../ui/widgets/overlay_loader.dart';

class GeneralMethods {
  static Future<CustomerInfo?> revenueCatResponse(
      {required BuildContext context}) async {
    OverLayLoader.showLoading(context);
    try {
      await Purchases.canMakePayments();
      await Purchases.logIn(MySharedPreferences.userId.toString());
      await Purchases.setAttributes({
        'User ID': MySharedPreferences.userId.toString(),
      });

      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      Loader.hide();
      return customerInfo;
    } catch (error) {
      print('error $error');
    }
    return null;
  }
}
