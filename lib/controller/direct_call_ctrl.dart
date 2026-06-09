import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';

import '../model/call_model.dart';
import '../utils/app_constants.dart';
import '../utils/shared_prefrences.dart';

class DirectCallCtrl extends GetxController {
  static DirectCallCtrl get find => Get.find();

  Stream<QuerySnapshot<CallModel>> getMyDirectCalls() {
    return FirebaseFirestore.instance
        .collection('calls')
        .where('doctorId', isEqualTo: MySharedPreferences.id)
        // .where('isActive', isEqualTo: true)
        // .where('canCall', isEqualTo: true)
        .orderBy('createdAt', descending: false)
        .withConverter<CallModel>(
          fromFirestore: (snapshot, _) => CallModel.fromJson(snapshot.data()!),
          toFirestore: (agora, _) => agora.toJson(),
        )
        .snapshots();
  }

  Future cancelCall(String callId, BuildContext context) async {
    AppConstants.showLoading(context);
    try {
      await FirebaseFirestore.instance
          .collection('calls')
          .doc(callId)
          .delete()
          .then((value) {
        AppConstants()
            .showMsgToast(context, msg: AppConstants.deletedSuccessfully);
      });
    } on FirebaseException {
      AppConstants().showMsgToast(context, msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }
}
