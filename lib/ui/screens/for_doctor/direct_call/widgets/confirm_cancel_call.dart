import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/api/notifications/send_notification.dart';

import '../../../../../utils/app_constants.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/shared_prefrences.dart';
import '../../../../widgets/custom_elevated_button.dart';

class ConfirmCancelcallDialog extends StatelessWidget {
  final int patientId;

  const ConfirmCancelcallDialog({
    Key? key,
    required this.patientId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              MySharedPreferences.language == 'ar'
                  ? 'هل تريد إلغاء طلب اتصال'
                  : "Are you sure",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: MyColors.blue14B,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Text(
            //   MySharedPreferences.language == 'ar'
            //       ? 'سيتم حذف الحساب بشكل كامل وسيتم حذف أي بيانات متعلقه به'
            //       : 'The account will be completely deleted and any data related to it will be deleted.',
            //   textAlign: TextAlign.start,
            //   style: const TextStyle(
            //     fontSize: 13,
            //     color: MyColors.red,
            //   ),
            // ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: 'No'.tr,
                        textColor: MyColors.blue14B,
                        onPressed: () {
                          Get.back();
                        },
                        color: MyColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomElevatedButton(
                        title: 'Yes'.tr,
                        textColor: MyColors.white,
                        onPressed: () async {
                          AppConstants.showLoading(context);
                          try {
                            await FirebaseFirestore.instance
                                .collection('calls')
                                .doc('$patientId${MySharedPreferences.id}')
                                .update({
                              'callStatus': AppConstants.canceled,
                            }).then((value) {
                              SendNotification().data(
                                  MySharedPreferences.fName,
                                  MySharedPreferences.language == 'ar'
                                      ? 'تم إلغاء طلب الاتصال المباشر'
                                      : 'Call Request Canceled',
                                  patientId.toString());
                              AppConstants().showMsgToast(context,
                                  msg: AppConstants.deletedSuccessfully);
                              Get.back();
                            });
                          } on FirebaseException {
                            AppConstants().showMsgToast(context,
                                msg: AppConstants.failedMessage);
                          }
                          Loader.hide();
                          // make call request
                          // Get.back();
                        },
                        color: MyColors.red,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
