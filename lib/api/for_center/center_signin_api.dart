import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../model/ErrorModel.dart';
import '../../model/center/center_login_model.dart';

class CenterLoginApi {
  Future data({
    required String phone,
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.centerSignIn}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone_number": phone,
        "password": password,
      });
      http.Response response =
          await http.post(uri, body: body, headers: headers);

      // log("center LoginStatusCode:: ${response.statusCode}  center LoginBody:: ${response.body}");

      if (response.statusCode == 200) {
        CenterLoginModel centerLoginModel =
            CenterLoginModel.fromJson(json.decode(response.body));
        return centerLoginModel;
      } else if (response.statusCode == 500) {
        ErrorModel errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      } else {
        throw "Center Login Error";
      }
    } catch (e) {
      log("Center Login Error $e");
      return null;
    }
  }
}
