import 'dart:convert';
import 'dart:developer';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/center/edit_center_info_model.dart';
class JoiningToCenterApi {
  static Future<EditCenterInfoModel?> request({
    required String doctorId,
    required String centerId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.joiningToCenter}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
        'authorization': MySharedPreferences.accessToken,
      };
      var body = jsonEncode({
        "doctor_id": doctorId,
        "center_id": centerId,
      });
      http.Response response = await http.post(uri, body: body, headers: headers);
      EditCenterInfoModel joinDoctorToCenter =
      EditCenterInfoModel.fromJson(json.decode(response.body));
      if(response.statusCode == 200){
        print('response.statusCode == 200');
        Loader.hide();
        return joinDoctorToCenter;
      }
      else if (response.statusCode == 500){
        print('response.statusCode == else');
        Loader.hide();
        throw "joinDoctorToCenterModel Error";
      }
    } catch (e) {
      // print('response.statusCode == catch');
      // log("joinDoctorToCenterModel $e");
      Loader.hide();
      return null;
    }
  }
}
