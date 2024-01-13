import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/delete_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class DeleteAccount {
  Future<DeleteModel?> deleteAccount() async {
    try {
      String url = MySharedPreferences.isDoctor
          ? '${ApiUrl.mainUrl}${ApiUrl.deleteAccount}/${MySharedPreferences.userId}'
          :'${ApiUrl.mainUrl}${ApiUrl.deleteCenter}/${MySharedPreferences.userId}';

      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };

      // log("Response:: delete Account Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("delete Account StatusCode:: ${response.statusCode} delete Account:: ${response.body}");

      DeleteModel deleteModel =
          DeleteModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return deleteModel;
      } else {
        throw "delete account   Error";
      }
    } catch (e) {
      log("delete account err:: $e");
    }
    return null;
  }
}
