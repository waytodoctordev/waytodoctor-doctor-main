import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../model/registration/sign_in_model.dart';

class ClinicLoginApi {
  // Future<ClinicLoginModel?> data({
  //   required String phone,
  //   required String password,
  // }) async {
  //   try {
  //     String url = '${ApiUrl.mainUrl}${ApiUrl.clinicSignIn}';
  //     Uri uri = Uri.parse(url);
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'X-localization': MySharedPreferences.language,
  //     };
  //     var body = jsonEncode({
  //       "phone": '${phone}0',
  //       "password": password,
  //     });
  //     log("Response:: Clinic LoginResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
  //     http.Response response =
  //         await http.post(uri, body: body, headers: headers);
  //     log("Clinic LoginStatusCode:: ${response.statusCode}  Clinic LoginBody:: ${response.body}");
  //     ClinicLoginModel clinicLoginModel =
  //         ClinicLoginModel.fromJson(json.decode(response.body));
  //     if (response.statusCode == 200) {
  //       return clinicLoginModel;
  //     } else if (response.statusCode == 500) {
  //       return clinicLoginModel;
  //     } else {
  //       throw "Clinic Login Error";
  //     }
  //   } catch (e) {
  //     log("Clinic Login Error $e");
  //     return null;
  //   }
  // }
  Future<SignInModel?> data({
    required String phone,
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.signInUser}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": '${phone}0',
        "password": password,
      });
      log("Response:: SignInResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("SignInStatusCode:: ${response.statusCode}  SignInBody:: ${response.body}");
      SignInModel signInModel =
          SignInModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return signInModel;
      } else if (response.statusCode == 500) {
        return signInModel;
      } else {
        throw "SignIn Error";
      }
    } catch (e) {
      log("SignIn Error $e");
      return null;
    }
  }
}
