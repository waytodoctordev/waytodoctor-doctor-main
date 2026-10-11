import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/services/secure_storage.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SendNotification {
  Future<void> data(
    String title,
    String content,
    String receiverFcmToken,
  ) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.sendNotification}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        'device_token': receiverFcmToken,
        'title': title,
        'content': content,
      });

      // print("Response:: send notification Response\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      print("send notification StatusCode:: ${response.statusCode} notificationBody:: ${response.body}");
    } catch (e) {
      print("deviceTokenError:: $e");
    }
  }
}
