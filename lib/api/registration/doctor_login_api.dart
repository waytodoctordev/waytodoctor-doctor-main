import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/doctor_login/doctor_login_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorLoginApi {
  Future<DoctorLoginModel?> data({
    required String phone,
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.doctorSignIn}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": phone,
        "password": password,
      });
      log("Response:: Doctor LoginResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("Doctor LoginStatusCode:: ${response.statusCode}  Doctor LoginBody:: ${response.body}");
      DoctorLoginModel doctorLoginModel = DoctorLoginModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return doctorLoginModel;
      } else if (response.statusCode == 500) {
        return doctorLoginModel;
      } else {
        throw "Doctor Login Error";
      }
    } catch (e) {
      log("Doctor Login Error $e");
      return null;
    }
  }
}
