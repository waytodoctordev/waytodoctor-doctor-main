// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../binding/for_doctor/doctor_base_nav_bar_binding.dart';
import '../../ui/base/for_doctor/doctor_base_nav_bar.dart';
import '../../ui/widgets/overlay_loader.dart';
import '../../utils/app_constants.dart';
import '../../utils/shared_prefrences.dart';


class SendEmailApi {
  static const link = 'https://api.emailjs.com/api/v1.0/email/send';
  static const serviceId = "service_d4j14ne"; // service_dga8ga8
  static const templateId = "template_ubov4to"; //template_kibj8m3
  static const userId = "BsucEti5Ae3z-3OM0"; //kdJ4pcQ38XFqx54Lk
  static Future sendEmailData({
    required String name,
    required String email,
    required String subject,
    required String message,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);

    try {
      String url = link;
      Uri uri = Uri.parse(url);
      var headers = {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
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
      log("Response:: SendEmailResponse\nUrl:: $url\nheaders:: ${headers.toString()}");
      http.Response response = await http.post(uri, headers: headers, body: body);
      log("SendEmailStatusCode:: ${response.statusCode} SendEmailBody:: ${response.body}");
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
      return null;
    }
  }
}
// serviceId:: service_d4j14ne
// templateId:: template_0v7u58f
// userId:: BsucEti5Ae3z-3OM0
