import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/registration/otp_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SendOtpApi {
  static Future<OtpModel?> data({
    required String phone,
    required String code,
  }) async {
    try {
      print('SendOtpApi');
      String url = '${ApiUrl.mainUrl}${ApiUrl.checkOtp}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "code": code,
        "phone": phone,
        "type": MySharedPreferences.skipOtp,
      });
      // log("Response:: CheckOtpResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      print(response.statusCode);
      print('response.statusCode');
      // log("CheckOtpStatusCode:: ${response.statusCode}  CheckOtpBody:: ${response.body}");
      OtpModel checkOtpModel = OtpModel.fromJson(json.decode(response.body));
      print('checkOtpModel');
      print(checkOtpModel.status);
      if (response.statusCode == 200) {
        print(response.statusCode);
        return checkOtpModel;
      } else if (response.statusCode == 500) {
        return checkOtpModel;
      } else {
        throw "CheckOtp Error";
      }
    } catch (e) {
      log("CheckOtp Error $e");
      return null;
    }
  }
}
