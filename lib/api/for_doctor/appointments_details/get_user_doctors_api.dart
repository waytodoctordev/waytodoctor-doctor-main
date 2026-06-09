import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/my_appointments/doctors_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class MydoctorsApi {
  static Future<DoctorsModel?> data({required int pageKey, required String userId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.getUserDoctors}/$userId?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::my Doctors Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("my Doctors StatusCode:: ${response.statusCode} my Doctors Body:: ${response.body}");
      DoctorsModel myDoctors = DoctorsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return myDoctors;
      } else {
        throw "my Doctors Error";
      }
    } catch (e) {
      log("my Doctors Error $e");
      return null;
    }
  }
}
