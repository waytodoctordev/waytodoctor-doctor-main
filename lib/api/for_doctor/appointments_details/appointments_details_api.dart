import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/my_appointments/view_appointment_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class GetAppointmentApi {
  static Future<ViewAppointmentModel?> data({required String appointmentId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.viewAppointmentData}/$appointmentId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::View Appointment Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("View Appointment StatusCode:: ${response.statusCode} View Appointment Body:: ${response.body}");
      ViewAppointmentModel descriptionModel = ViewAppointmentModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return descriptionModel;
      } else {
        throw "View Appointment Error";
      }
    } catch (e) {
      log("View Appointment Error $e");
      return null;
    }
  }
}
