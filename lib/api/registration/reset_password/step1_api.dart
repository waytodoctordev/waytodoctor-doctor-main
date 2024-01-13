import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/registration/reset_password/reset_pass_step1_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ResetPassStep1Api {
  static Future<ResetPassStep1Model?> data({
    required String phone,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.resetPassStep1}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone":  phone,//MySharedPreferences.countryCode +
      });
      // log("Response:: ResetPassStep1Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      // log("ResetPassStep1StatusCode:: ${response.statusCode}  ResetPassStep1Body:: ${response.body}");
      ResetPassStep1Model resetPassStep1Model = ResetPassStep1Model.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return resetPassStep1Model;
      } else if (response.statusCode == 500) {
        return resetPassStep1Model;
      } else {
        throw "ResetPassStep1 Error";
      }
    } catch (e) {
      log("ResetPassStep1 Error $e");
      return null;
    }
  }
}
