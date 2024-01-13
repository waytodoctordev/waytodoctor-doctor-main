import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/ErrorModel.dart';
import '../../model/center/center_login_model.dart';
import '../../utils/api_url.dart';
class CenterSignUpApi {
  Future data({
    required String name,
     // String? address,
    required String phone,
    required String centerCategoryId,
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.centerSignUp}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        'name': name,
        'center_category_id': centerCategoryId,
        "phone_number": phone,
        "password": password,
      });
      http.Response response =
      await http.post(uri, body: body, headers: headers);
      if (response.statusCode == 200) {
        CenterLoginModel centerLoginModel =
        CenterLoginModel.fromJson(json.decode(response.body));
        return centerLoginModel;
      } else if (response.statusCode == 500) {
        ErrorModel errorModel = ErrorModel.fromJson(json.decode(response.body));
        return errorModel;
      } else {
        throw "Center Create Account Error";
      }
    } catch (e) {
      log("Center Create Account  Error $e");
      return null;
    }
  }
}
