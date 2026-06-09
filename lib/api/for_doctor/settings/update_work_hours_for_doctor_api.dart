import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_data_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateWorkHoursForDoctorApi {
  static Future<WorkHoursDataModel?> data({
    required String dayId,
    required String from,
    required String to,
    required String status,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateWorkHours}/$dayId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "start_at": from,
        "end_at": to,
        "status": status,
        "doctor_id": MySharedPreferences.id,
      });
      log("Response:: Work Hours Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      log("Work Hours StatusCode:: ${response.statusCode}  Work Hours Body:: ${response.body}");
      WorkHoursDataModel workHoursDataModel = WorkHoursDataModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return workHoursDataModel;
      } else {
        throw "Work Hours  Error";
      }
    } catch (e) {
      log("Work Hours  Error $e");
      return null;
    }
  }
}
