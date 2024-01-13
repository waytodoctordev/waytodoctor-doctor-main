import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/notifications/notifications_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorNotificationsApi {
  static Future<NotificationModel?> data({
    required int pageKey,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.notifications}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Notifications Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Notifications StatusCode:: ${response.statusCode}  Notifications Body:: ${response.body}");
      NotificationModel notificationModel = NotificationModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return notificationModel;
      } else {
        throw "Notifications  Error";
      }
    } catch (e) {
      log("Notifications  Error $e");
      return null;
    }
  }
}
