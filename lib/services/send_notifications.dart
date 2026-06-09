import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SendCallNotification {
  Future callNotification(
      {required String status,
      required String token,
      required String mbody,
      required String title,
      required String callToken,
      required String channelName,
      required String doctorName,
      required BuildContext context,
      required bool isVideo,
      required int doctorId}) async {
    try {
      String? t;
      t = await FirebaseMessaging.instance.getToken();
      // AppConstants.showLoading(context);
      final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${MySharedPreferences.accessToken}',
      };
      var body = jsonEncode({
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'status': status,
          'callToken': callToken,
          'channelName': channelName,
          'isVideo': isVideo,
          'doctorName': doctorName,
          'doctorId': doctorId,
        },
        "notification": <String, dynamic>{
          'title': title,
          'body': mbody,
          'android_channel': 'ozonechannel',
        },
        "to": token,
      });
      http.Response response =
          await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        log("SendEmailStatusCode:: ${response.statusCode} SendEmailBody:: ${response.body}");
        Loader.hide();

        return response;
      } else {
        // Loader.hide();
        log("SendEmailStatusCode:: ${response.statusCode} SendEmailBody:: ${response.body}");
        return null;
      }
    } catch (e) {
      log("$e");
      return null;
    }
  }

  Future chatNotification(
      {required String status,
      required String token,
      required String mbody,
      required String title,
      required String appointmentStatus,
      required BuildContext context,
      required String bookingType,
      required int appointmentId}) async {
    try {
      String? t;
      t = await FirebaseMessaging.instance.getToken();
      // log(t!);
      // AppConstants.showLoading(context);
      // final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      final url = Uri.parse('https://fcm.googleapis.com/v1/projects/way-to-doctor-7a9d5/messages:send');
      var headers = {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $token'   };
        var body =jsonEncode({
          "message": {
            "topic": "news",
            "notification": {
              'title': title,
              'body': mbody,
            },
           'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'status': status,
            'bookingType': bookingType,
            'appointmentId': appointmentId,
            'doctorUserId': MySharedPreferences.userId,
            'doctorImage': MySharedPreferences.userImage,
            'doctorName': MySharedPreferences.fName,
            'doctorId': MySharedPreferences.id,
            'AppointmentStatus': appointmentStatus,
          },
        }});
      http.Response response =
          await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('response.statusCode == 200');
        print("Send Chat Notification StatusCode:: ${response.statusCode} Send Chat Notification Body:: ${response.body}");
        Loader.hide();
        return response;
      } else {
        log("Send Chat Notification StatusCode:: ${response.statusCode} Send Chat Notification Body:: ${response.body}");
        Loader.hide();
        return null;
      }
    } catch (e) {
      log("$e");
      Loader.hide();
      return null;
    }
  }
}
