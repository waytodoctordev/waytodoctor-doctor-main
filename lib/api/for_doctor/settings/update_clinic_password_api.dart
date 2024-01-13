import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateClinicPasswordByDoctorApi {
  static Future<UserModel?> data({
    required String password,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.updateUser}/${MySharedPreferences.clinicUserID}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "password": password,
        // "phone": MySharedPreferences.userNumber,
      });
      log("Response:: Clinic PasswordResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Clinic PasswordStatusCode:: ${response.statusCode}  Clinic PasswordBody:: ${response.body}");
      UserModel userModel = UserModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return userModel;
      } else {
        throw "Clinic Password Error";
      }
    } catch (e) {
      log("Clinic Password Error $e");
      return null;
    }
  }
}
