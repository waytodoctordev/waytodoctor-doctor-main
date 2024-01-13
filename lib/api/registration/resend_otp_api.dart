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
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateUserNumber}/$userId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      http.Response response = await http.post(uri, headers: headers);
      ResendOtpModel resendOtpModel = ResendOtpModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return resendOtpModel;
      } else if (response.statusCode == 500) {
        return resendOtpModel;
      } else {
        throw "Edit Number Error";
      }
    } catch (e) {
      log("Edit Number  Error $e");
      return null;
    }
  }
}
