import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:way_to_doctor_doctor/model/call_model.dart';
import 'package:way_to_doctor_doctor/ui/screens/messanger/audio_call_screen.dart';

import '../../../../../services/agora_token_service.dart';
import '../../../../../services/send_notifications.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/shared_prefrences.dart';
import '../../../../widgets/custom_elevated_button.dart';

const token =
    "007eJxTYFjloiinamk4q1Bvv1xCmqbgtGt/yx7pXpi+uE0u6izn/mkKDGmWhgYpxgYGlhamKSZGRkkWiaaWSUDSIjHZwMTS0iTf+1ByQyAjw8VpL1gYGSAQxOdgSMxITStNzEhjYAAAJSQfsw==";
const channelName = "ahefuahf";

class ConfirmStartCallDialog extends StatelessWidget {
  final CallModel callModel;

  const ConfirmStartCallDialog({
    Key? key,
    required this.callModel,
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
              'The duration of the call will be 10 minutes.'.tr,
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
                        title: 'Cancel'.tr,
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
                        title: 'Approve'.tr,
                        textColor: MyColors.white,
                        onPressed: () async {
                          var channelName = const Uuid().v1();
                          String? token =
                              await GetAgoraToken().init(channelName, context);
                          if (token != null) {
                            // SendCallerNotification().init(callModel.patientId);
                            await SendCallNotification().callNotification(
                              status: 'DIRECT_CALL',
                              token: callModel.accessToken,
                              mbody: MySharedPreferences.language == 'ar'
                                  ? 'يتصل بك'
                                  : 'Calling You',
                              title: callModel.doctorName,
                              callToken: token,
                              channelName: channelName,
                              doctorName: callModel.doctorName,
                              context: context,
                              isVideo: false,
                              doctorId: callModel.doctorId,
                            );
                            await FirebaseFirestore.instance
                                .collection('calls')
                                .doc(
                                    '${callModel.patientId}${MySharedPreferences.id}')
                                .update({
                              'token': token,
                              'channelName': channelName,
                            });

                            Get.to(() => AudioCallScreen(
                                      token: token,
                                      channelName: channelName,
                                      patientId: callModel.patientId,
                                      patientName: callModel.patientName,
                                    ))!
                                .then((value) => Get.back());
                          }
                        },
                        color: MyColors.blue14B,
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
