import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateAddressForDoctorApi {
  static Future<DoctorDetailsModel?> address({
    required double lat,
    required double long,
    required String address,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "address": address,
        "lat": lat,
        "long": long,
      });
      log("Response:: Doctor DetailsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("Doctor DetailsStatusCode:: ${response.statusCode}  Doctor DetailsBody:: ${response.body}");
      DoctorDetailsModel doctorDetailsModel = DoctorDetailsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return doctorDetailsModel;
      } else {
        throw "Doctor Details Error";
      }
    } catch (e) {
      log("Doctor Details Error $e");
      return null;
    }
  }
}
