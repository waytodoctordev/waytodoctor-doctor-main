import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class MyNextAppointmentsApi {
  static Future<MyAppointmentsModel?> data({required int pageKey}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.nextAppointmentsByclinic}/${MySharedPreferences.id}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Next AppointmentsResponse\nUrl:: $url\n headers:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Next AppointmentsStatusCode:: ${response.statusCode}  AppointmentsBody:: ${response.body}");
      MyAppointmentsModel appointmentModel = MyAppointmentsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return appointmentModel;
      } else {
        throw "Next Appointments Error";
      }
    } catch (e) {
      log("Next Appointments Error $e");
      return null;
    }
  }
}
