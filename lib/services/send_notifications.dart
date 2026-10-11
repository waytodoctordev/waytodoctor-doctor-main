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
          'doctorId': doctorId.toString(),
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

  // Future chatNotification(
  //     {required String status,
  //     required String token,
  //     required String mbody,
  //     required String title,
  //     required String appointmentStatus,
  //     required BuildContext context,
  //     required String bookingType,
  //     required int appointmentId}) async {
  //   try {
  //     String? t;
  //     t = await FirebaseMessaging.instance.getToken();
  //     // log(t!);
  //     // AppConstants.showLoading(context);
  //     // final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  //     final url = Uri.parse('https://fcm.googleapis.com/v1/projects/way-to-doctor-7a9d5/messages:send');
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization':
  //           'Bearer ya29.c.c0ASRK0Ga3AdEiYAI1WdC5lwJZYSE5sB0I4e7mdhjQ4vvQoo-cV04sLtGMH7wMwEimyISpMvw6tv1RyAu1s1BWcMQumztmP0idM6OuR99cu5xn75umvB8kKOYHewnVVwnA-_pBvc1RthIfk_vSStlFpIdJ7bfRZmm_unCk8WQGZ_29QdAnwERw9_gBNDXslbVsQIS26CM0Mn0p-xw9n7TN1NFuJ5jinAjz43Xk0G0Y2VmVtFpTxcBicGphZMjG84oJ3usvcllQ7TIC2u9FNkFmdAKVPRFg5-nTxCMbWck9zxOmdtaivTkiQswjdQLa30rX_-XQhg_DL9fQd1wRhmFNLpLqCEnsErC0C7hJwvH_3AxLlnoGEErPIyeSN385CRVSuY5twz4qc4ujjvdjgY2Xh94VeIm9sxad_kFeYSz_S0IeUbq0pbov6kk3umttaR-_1kfhUWn0ssrpg9lbd2-zbQlIkiQbRgp1Vvodtk62FpmBtOupYROZpgQvziIzrw--21YvyWik-Zi_95aU3bzB1Ju4RbM6ntkuipQtduZ5cc1Ms0cQJcsOuBIyde--fVyZJfxth-Sb1Uov4m7_cq2XOdYob-vq9fYOp9xsd0rxy2Me2jn_c7hcwuo3BwuZx_jiU18R68shS0Uswyhgv8zZJWk28jlo_cMthRg3UVQJJq5qFh3kSRnwanSUdJ7m1j_-qM7YUe41t702l1rtXoB4Xx-I93pQxh-IrQu6niobjoJwgnUc8582s3WodOxsiOufnXtWeiRyFhu3IVU-7c2aY4R3a-a39bucMR4cIltwdzxu6l5WpQ9dJoj9BVRUB4y9gIyS6F7cao6ho10XROdZY12lM4-Zhob-6lkQMg2tw7m-jx9Om_9jQ53-Sf8mekxXn41yJ7yphaI6uemgFaSYhJ3ljuo-txrrFSBmY90mwvxp-FpBlRiqtqq64W1626V15tnjJ2uzVFW5q6OMm4URk8xvom8W-3s',  };
  //       var body =jsonEncode({
  //         "message": {
  //           "topic": "news",
  //           "notification": {
  //             'title': title,
  //             'body': mbody,
  //           },
  //          'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'status': status,
  //           'bookingType': bookingType,
  //           'appointmentId': appointmentId.toString(),
  //           'doctorUserId': MySharedPreferences.userId,
  //           'doctorImage': MySharedPreferences.userImage,
  //           'doctorName': MySharedPreferences.fName,
  //           'doctorId': MySharedPreferences.id.toString(),
  //           'AppointmentStatus': appointmentStatus,
  //         },
  //       }});
  //     http.Response response =
  //         await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       print('response.statusCode == 200');
  //       print("Send Chat Notification StatusCode:: ${response.statusCode} Send Chat Notification Body:: ${response.body}");
  //       Loader.hide();
  //       return response;
  //     } else {
  //       log("Send Chat Notification StatusCode:: ${response.statusCode} Send Chat Notification Body:: ${response.body}");
  //       Loader.hide();
  //       return null;
  //     }
  //   } catch (e) {
  //     log("$e");
  //     Loader.hide();
  //     return null;
  //   }
  // }
}
