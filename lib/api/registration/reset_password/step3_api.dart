import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/registration/reset_password/reset_pass_step3_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ResetPassStep3Api {
  static Future<ResetPassStep3Model?> data({
    required String phone,
    required String password,
  }) async {
    print(MySharedPreferences.countryCode + phone);

    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.resetPassStep3}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": phone,//MySharedPreferences.countryCode +
        "password": password,
      });
      log("Response:: ResetPassStep3Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("ResetPassStep3StatusCode:: ${response.statusCode}  ResetPassStep3Body:: ${response.body}");
      ResetPassStep3Model resetPassStep3Model = ResetPassStep3Model.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return resetPassStep3Model;
      } else if (response.statusCode == 500) {
        return resetPassStep3Model;
      } else {
        throw "ResetPassStep3 Error";
      }
    } catch (e) {
      log("ResetPassStep3 Error $e");
      return null;
    }
  }
}
