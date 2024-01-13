import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/clinic_model/clinic_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateCommunicationForClinicApi {
  static Future<ClinicModel?> data({
    required double lat,
    required double long,
    required String address,
    // required String phone,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.updateClinicData}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "address": address,
        // "phone": MySharedPreferences.countryCode + phone,
        "lat": lat,
        "long": long,
      });
      log("Response:: Clinic DetailsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Clinic DetailsStatusCode:: ${response.statusCode}  Clinic DetailsBody:: ${response.body}");
      ClinicModel clinicModel =
          ClinicModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return clinicModel;
      } else {
        throw "Clinic Details Error";
      }
    } catch (e) {
      log("Clinic Details Error $e");
      return null;
    }
  }
}
