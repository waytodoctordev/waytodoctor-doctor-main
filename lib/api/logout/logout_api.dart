import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';

import '../../utils/shared_prefrences.dart';

class Logout {
  Future<void> logout() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.logout}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };

      log("Response:: logout Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("logout StatusCode:: ${response.statusCode} updateTokenBody:: ${response.body}");
    } catch (e) {
      log("logout Error:: $e");
    }
  }
}
