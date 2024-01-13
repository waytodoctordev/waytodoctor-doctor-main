import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UrgentsAppointmentsApi {
  static Future<MyAppointmentsModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.urgentsAppointmentsForDoctor}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Sliders Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Sliders StatusCode:: ${response.statusCode}  Sliders Body:: ${response.body}");
      MyAppointmentsModel appointmentsModelTypes = MyAppointmentsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return appointmentsModelTypes;
      } else if (response.statusCode == 500) {
        return appointmentsModelTypes;
      } else {
        throw "Slider Error";
      }
    } catch (e) {
      log("Slider Error $e");
      return null;
    }
  }
}
