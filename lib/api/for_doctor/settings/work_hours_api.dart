import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/work_hours/work_hours_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class WorkHoursForDoctorApi {
  static Future<WorkHoursModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.workHoursForDoctor}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response:: Work Hours Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Work Hours StatusCode:: ${response.statusCode}  Work Hours Body:: ${response.body}");
      WorkHoursModel workHoursModel = WorkHoursModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return workHoursModel;
      } else {
        throw "Work Hours  Error";
      }
    } catch (e) {
      log("Work Hours  Error $e");
      return null;
    }
  }
}
