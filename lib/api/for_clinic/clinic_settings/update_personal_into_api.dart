import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/clinic_model/clinic_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateInformationForClinicApi {
  static Future<ClinicModel?> data({
    required String userName,
    required String email,
    required String phone,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateClinicData}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        // "email": email,
        "phone": MySharedPreferences.countryCode + phone,
        "name": userName,
      });
      log("Response:: clinic DetailsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("clinic DetailsStatusCode:: ${response.statusCode}  clinic DetailsBody:: ${response.body}");
      ClinicModel clinicModel = ClinicModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return clinicModel;
      } else {
        throw "clinic Details Error";
      }
    } catch (e) {
      log("clinic Details Error $e");
      return null;
    }
  }
}
