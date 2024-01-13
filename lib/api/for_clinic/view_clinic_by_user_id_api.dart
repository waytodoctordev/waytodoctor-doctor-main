import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../../model/clinic_login/view_vclinic_by_user_id_model.dart';

class ViewClinicByUserIdApi {
  static Future<ViewClinicByUserIdModel?> data({required String userId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.viewClinicByUserId}/$userId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response:: View Clinic By User Ids Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("View Clinic By User Ids StatusCode:: ${response.statusCode}  View Clinic By User Ids Body:: ${response.body}");
      ViewClinicByUserIdModel clinicdata =
          ViewClinicByUserIdModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return clinicdata;
      } else if (response.statusCode == 500) {
        return clinicdata;
      } else {
        throw "View Clinic By User Id Error";
      }
    } catch (e) {
      log("View Clinic By User Id Error $e");
      return null;
    }
  }
}
