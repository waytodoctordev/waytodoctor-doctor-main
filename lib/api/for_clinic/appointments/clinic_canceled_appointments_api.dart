import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ClinicCanceledAppointmentsApi {
  static Future<MyAppointmentsModel?> data({required int pageKey}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.canceledAppointmentsByclinic}/${MySharedPreferences.id}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response::Canceled AppointmentsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Canceled AppointmentsStatusCode:: ${response.statusCode}  AppointmentsBody:: ${response.body}");
      MyAppointmentsModel appointmentModel = MyAppointmentsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return appointmentModel;
      } else {
        throw "Canceled Appointments Error";
      }
    } catch (e) {
      log("Canceled Appointments Error $e");
      return null;
    }
  }
}
