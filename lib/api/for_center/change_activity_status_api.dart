import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/main_model.dart';

class ChangeActivityStatusApi {
  static Future<MainModel?> request({
    required String doctorId,
    required bool activityStatus,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.changeActivityStatus}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
        'authorization': MySharedPreferences.accessToken,
      };
      var body = jsonEncode({
        "doctor_id": doctorId,
        "center_status": activityStatus,
      });
      // log("Response:: Countries Response\nUrl:: $url\nheaders:: $headers");
      http.Response response =
      await http.post(uri, body: body, headers: headers);
      // log("Countries StatusCode:: ${response.statusCode}  Countries Body:: ${response.body}");
      MainModel changeActivityStatusModel =
          MainModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return changeActivityStatusModel;
      } else {
        throw "changeActivityStatusModel Error";
      }
    } catch (e) {
      log("changeActivityStatusModel $e");
      return null;
    }
  }
}
