import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/my_appointments/my_appointments_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class AppointmentsByDateForDoctorApi {
  static Future<MyAppointmentsModel?> data({
    required String date,
    required int pageKey,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.appointmentsByDateForDoctor}?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        'doctor_id': MySharedPreferences.id,
        'date': date,
      });

      // log("Response:: Appointments Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("Appointments StatusCode:: ${response.statusCode}  Appointments Body:: ${response.body}");
      MyAppointmentsModel appointmentModel = MyAppointmentsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return appointmentModel;
      } else {
        throw "Appointments Error";
      }
    } catch (e) {
      log("Appointments Error $e");
      return null;
    }
  }
}
