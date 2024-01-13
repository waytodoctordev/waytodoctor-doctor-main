import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/home_screen/slider_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class SlidersApi {
  static Future<SlidersModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.sliders}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Sliders Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Sliders StatusCode:: ${response.statusCode}  Sliders Body:: ${response.body}");
      SlidersModel slidersModel = SlidersModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return slidersModel;
      } else if (response.statusCode == 500) {
        return slidersModel;
      } else {
        throw "Slider Error";
      }
    } catch (e) {
      log("Slider Error $e");
      return null;
    }
  }
}
