import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:way_to_doctor_doctor/services/api_request_handlers/api_service.dart';
import '../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../model/call_model.dart';
import '../../model/pages_model.dart';
import '../../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../../ui/widgets/overlay_loader.dart';
import '../../utils/api_url.dart';
import '../../utils/app_constants.dart';
import '../../utils/shared_prefrences.dart';
class PoliciesCtrl extends GetxController {
  static PoliciesCtrl get find => Get.find();

  ApiService apiRequestService = ApiService();
  PageModel? pageModel;
  Stream<QuerySnapshot<CallModel>> getMyDirectCalls() {
   return FirebaseFirestore.instance
        .collection('calls')
        .where('doctorId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
  /// DONE . => POLICY PAGE API REPLACED WITH OLD PagesApi API
  Future<PageModel?> policyPageDetails(String pageId) async {
    pageModel =  await apiRequestService.makeRequest(
        method: AppConstants.getMethod,
        url: '${ApiUrl.mainUrl}${ApiUrl.pages}/$pageId',
        fromJson: (json)=>PageModel.fromJson(json),);
    return pageModel;
  }

    Future sendEmailData({
      required String name,
      required String email,
      required String subject,
      required String message,
      required BuildContext context,
    }) async {
      const link = 'https://api.emailjs.com/api/v1.0/email/send';
      const serviceId = "service_d4j14ne"; // service_dga8ga8
      const templateId = "template_ubov4to"; //template_kibj8m3
      const userId = "BsucEti5Ae3z-3OM0";
      OverLayLoader.showLoading(context);
      try {
      var response =await apiRequestService.makeRequest(
          method: AppConstants.postMethod,
          url: link,
          body: {
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        },
      });
      if (response.statusCode == 200) {
        AppConstants().showMsgToast(context, msg:'Message has been sent'.tr);
        log("SendEmailStatusCode:: ${response.statusCode} SendEmailBody:: ${response.body}");
        Loader.hide();
        MySharedPreferences.lastScreen = 'BaseNavBar';
        Get.offAll(() => const DoctorBaseNavBar(), binding: DoctorBaseNavBarBinding());
        return response;
      } else {
        Loader.hide();
        log("SendEmailStatusCode:: ${response.statusCode} SendEmailBody:: ${response.body}");
        return null;
      }
    } catch (e) {
     log("$e");
     }


  }}
