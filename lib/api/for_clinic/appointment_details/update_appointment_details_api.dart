import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/update_appointment_for_clinic/update_appointment_for_clinic_api.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateAppointmentForClinicApi {
  static Future<UpdateAppointmentModel?> data({
    required String appointmentId,
    required String time,
    required String date,
    required String status,
    required String type,
    required String bokkingType,
    required String location,
    required String pay,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.updateAppointmentData}/$appointmentId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "time": time,
        "date": date,
        "status": status,
        "type": type,
        "booking_type": bokkingType,
        "location": location,
        "payment_method": pay,
      });
      log("Response:: Update AppointmentResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Update AppointmentStatusCode:: ${response.statusCode}  Update AppointmentBody:: ${response.body}");
      UpdateAppointmentModel appointmentsModel =
          UpdateAppointmentModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return appointmentsModel;
      } else {
        throw "Update Appointment Error";
      }
    } catch (e) {
      log("Update Appointment Error $e");
      return null;
    }
  }
}