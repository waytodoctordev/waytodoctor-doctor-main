import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdatePasswordApi {
  static Future<UserModel?> data({
    required String password,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateUser}/${MySharedPreferences.userId}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "password": password,
      });
      // log("Response:: Doctor DetailsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      // log("Doctor DetailsStatusCode:: ${response.statusCode}  Doctor DetailsBody:: ${response.body}");
      UserModel doctorDetailsModel = UserModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        print('response.statusCode == 200');
        return doctorDetailsModel;
      } else {
        print('Doctor Details Error');
        throw "Doctor Details Error";
      }
    } catch (e) {

      log("Doctor Details Error $e");
      return null;
    }
  }
}
