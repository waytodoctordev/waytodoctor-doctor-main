import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../model/notifications/get_device_token_model.dart';

class SendCallerNotification {
  static Future<GetDeviceTokenOfUserModel?> data({required int userId}) async {
    try {
      String url = '${ApiUrl.mainUrl}/api/v1/send-call/$userId';
      Uri uri = Uri.parse(url);
      Map<String, String>? headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
      };

      // log("Response:: DeviceToken  Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("DeviceToken StatusCode:: ${response.statusCode}  DeviceToken  Body:: ${response.body}");
      GetDeviceTokenOfUserModel deviceTokenOfUserModel =
          GetDeviceTokenOfUserModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return deviceTokenOfUserModel;
      } else {
        throw "DeviceToken  Error";
      }
    } catch (e) {
      log("DeviceToken  Error $e");
      return null;
    }
  }
}
