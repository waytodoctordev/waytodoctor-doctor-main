import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/user_medical_info_model/user_medical_info_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UserMedicalInfiApi {
  static Future<MedicalInfoModel?> data({required String userId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.userMedicalInfo}/$userId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Medical info Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Medical info StatusCode:: ${response.statusCode} Medical info Body:: ${response.body}");
      MedicalInfoModel medicalInfoModel =
          MedicalInfoModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return medicalInfoModel;
      } else {
        throw "Medical info Error";
      }
    } catch (e) {
      log("Medical info Error $e");
      return null;
    }
  }
}
