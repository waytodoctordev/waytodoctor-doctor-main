import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/registration/resend_otp_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ReSendOtpApi {
  static Future<ResendOtpModel?> data({
    required int userId,
  }) async {
    try {
      print(' MySharedPreferences.userNumber ${ MySharedPreferences.userNumber}');
      String url = '${ApiUrl.mainUrl}${ApiUrl.resetPassStep1}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": MySharedPreferences.userNumber,
      });
      http.Response response = await http.post(uri, headers: headers,body: body);
      print(response.body);

      ResendOtpModel resendOtpModel = ResendOtpModel.fromJson(json.decode(response.body));
     print(resendOtpModel.status);
      if (response.statusCode == 200) {
        print('response.statusCode == 200');
        return resendOtpModel;
      }
      else if (response.statusCode == 500) {
        print('response.statusCode == 500');

        return resendOtpModel;
      }
      else {
        throw "Edit Number Error";
      }
    } catch (e) {
      log("Edit Number  Error $e");
      return null;
    }
  }
}
