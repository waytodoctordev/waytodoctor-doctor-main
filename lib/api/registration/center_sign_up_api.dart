import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/center/center_login_model.dart';
import 'package:way_to_doctor_doctor/model/clinic_login/clinic_login_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CenterSignUpApi {
  Future<CenterLoginModel?> data({
    required String email,
    required String password,
    required String name,
    required String categoryId,
    required String image,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.centerSignUp}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone_number": phoneNumber,
        "password": password,
        "email": email,
        "name": name,
        "address": address,
        "image": image,
      });
      log("Response:: center SignUpResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("CenterSignUpStatusCode:: ${response.statusCode}  SignUpBody:: ${response.body}");
      CenterLoginModel centerLoginModel = CenterLoginModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return centerLoginModel;
      } else if (response.statusCode == 500) {
        return centerLoginModel;
      } else {
        throw "center SignUp Error";
      }
    } catch (e) {
      log("center SignUp Error $e");
      return null;
    }
  }
}
