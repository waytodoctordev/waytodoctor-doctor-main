import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/home_screen/appointment_counter_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class AppointmentsCounterApi {
  static Future<AppointmentCounterModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.counterForDoctor}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Counters Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Counters StatusCode:: ${response.statusCode}  Counters Body:: ${response.body}");
      AppointmentCounterModel appointmentsModelTypes = AppointmentCounterModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return appointmentsModelTypes;
      } else if (response.statusCode == 500) {
        return appointmentsModelTypes;
      } else {
        throw "Counter Error";
      }
    } catch (e) {
      log("Counter Error $e");
      return null;
    }
  }
}
