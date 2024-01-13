import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DoctorDescriptionsApi {
  static Future<ReplaysModel?> data({required String appointmentId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.doctorDescriptions}/$appointmentId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Doctor Description Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Doctor Description StatusCode:: ${response.statusCode} Doctor Description Body:: ${response.body}");
      ReplaysModel descriptionModel = ReplaysModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return descriptionModel;
      } else {
        throw "Doctor Description Error";
      }
    } catch (e) {
      log("Doctor Description Error $e");
      return null;
    }
  }
}
