import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class GetStepApi {
  static Future<UserModel?> getStepAndQuestion({required String token}) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.profile}/${MySharedPreferences.userId}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Step Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Step StatusCode:: ${response.statusCode}  Step Body:: ${response.body}");
      UserModel stepAndActiveModel =
          UserModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return stepAndActiveModel;
      } else {
        throw "Step  Error";
      }
    } catch (e) {
      log("Step  Error $e");
      return null;
    }
  }
}
