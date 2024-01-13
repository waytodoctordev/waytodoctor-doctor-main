import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../model/user_other_doctors/user_other_doctors_model.dart';
import '../../../utils/api_url.dart';
import '../../../utils/shared_prefrences.dart';

class GetOtherDoctorsApi {
  static Future<OtherDoctorsModel?> myOtherDoctors(
      {required int pageKey, required String userId}) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.getMyOtherDoctors}/$userId?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response:: other doctorsResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("other doctorsStatusCode:: ${response.statusCode}  other doctorsBody:: ${response.body}");
      OtherDoctorsModel otherDoctorsModel =
          OtherDoctorsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return otherDoctorsModel;
      } else {
        throw "other doctors Error";
      }
    } catch (e) {
      log("other doctors Error $e");
      return null;
    }
  }
}
