import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/registration/cities_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CitiesListApi {
  static Future<CitiesModel?> data({
    required countryId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.cities}/$countryId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response:: Cities Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Cities StatusCode:: ${response.statusCode}  Cities Body:: ${response.body}");
      CitiesModel citiesModel = CitiesModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return citiesModel;
      } else {
        throw "Cities  Error";
      }
    } catch (e) {
      log("Cities  Error $e");
      return null;
    }
  }
}
