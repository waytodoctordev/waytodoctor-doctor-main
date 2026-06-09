import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/update_appointment_for_clinic/update_appointment_for_clinic_api.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class ViewAppointmentForClinicApi {
  static Future<UpdateAppointmentModel?> data({
    required String appointmentId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.viewAppointmentData}/$appointmentId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };

      log("Response:: Get AppointmentResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Get AppointmentStatusCode:: ${response.statusCode}  Get AppointmentBody:: ${response.body}");
      UpdateAppointmentModel appointmentsModel = UpdateAppointmentModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return appointmentsModel;
      } else {
        throw "Get Appointment Error";
      }
    } catch (e) {
      log("Get Appointment Error $e");
      return null;
    }
  }
}
