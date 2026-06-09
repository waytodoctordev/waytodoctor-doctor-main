import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/doctor_signup/doctor_signup_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorSignUpApi {
  Future<DoctorSignUpModel?> data({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.doctorSignUp}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": email,
        "password": password,
        "email": email,
        "name": name,
      });
      // log("Response:: Doctor SignUpResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      // log("DoctorSignUpStatusCode:: ${response.statusCode}  SignUpBody:: ${response.body}");
      DoctorSignUpModel signUpModel = DoctorSignUpModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return signUpModel;
      } else if (response.statusCode == 500) {
        return signUpModel;
      } else {
        throw "Doctor SignUp Error";
      }
    } catch (e) {
      log("Doctor SignUp Error $e");
      return null;
    }
  }
}
