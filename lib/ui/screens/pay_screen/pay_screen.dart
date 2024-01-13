import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/controller/payment/payment_ctrl.dart';
import 'package:way_to_doctor_doctor/ui/widgets/loading_indicator.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../controller/form/form_ctrl.dart';

class PayScreenMontyPay extends StatefulWidget {
  final String payUrl;
  final String planId;
  final int daysOfPlan;
  final int copounId;
  const PayScreenMontyPay(
      {super.key,
      required this.payUrl,
      required this.planId,
      required this.daysOfPlan,
      required this.copounId});


  @override
  State<PayScreenMontyPay> createState() => _PayScreenMontyPayState();
}

class _PayScreenMontyPayState extends State<PayScreenMontyPay> {
  @override
  void initState() {
    // Map<String, dynamic> args = Get.arguments;
    Get.put(PaymentCtrl());
    Get.lazyPut(() => FormCtrl());
    PaymentCtrl.find.initWebView(widget.payUrl, context, widget.planId,
        widget.daysOfPlan, widget.copounId);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: GetBuilder<PaymentCtrl>(
        builder: (controller) {
          if (controller.isUrlLoaded) {
            if (controller.isPaymentEnded) {
              // يرجى الانتظار ريثما يتم التحقق من عملية الدفع
              return Container(
                  height: Get.height,
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const LoadingIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Please wait while your payment is being verified.'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: MyColors.blue14B),
                      )
                    ],
                  ));
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: 19),
                child: WebViewWidget(
                  controller: controller.webViewController,
                ),
              );
            }
          } else {
            return SizedBox(
                height: Get.height,
                width: Get.width,
                // color: MyColors.blue14B.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const LoadingIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Please wait'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: MyColors.blue14B),
                    )
                  ],
                ));
          }
        },
      )),
    );
  }
}
