import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/clinic_login/clinic_login_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ClinicSignUpApi {
  Future<ClinicLoginModel?> data({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.clinicSignUp}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": 'phone',
        "password": password,
        "email": email,
        "name": name,
      });
      log("Response:: Clinic SignUpResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("DoctorSignUpStatusCode:: ${response.statusCode}  SignUpBody:: ${response.body}");
      ClinicLoginModel clinicSignupModel = ClinicLoginModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return clinicSignupModel;
      } else if (response.statusCode == 500) {
        return clinicSignupModel;
      } else {
        throw "Clinic SignUp Error";
      }
    } catch (e) {
      log("Clinic SignUp Error $e");
      return null;
    }
  }
}
