import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/copoun_model/copun_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CopounApi {
  static Future<CopounModel?> data({required String copounName}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.coupon}/$copounName';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };

      // log("Response:: Copoun  Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Copoun StatusCode:: ${response.statusCode}  Copoun  Body:: ${response.body}");
      CopounModel copounModel =
          CopounModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return copounModel;
      } else {
        throw "Copoun  Error";
      }
    } catch (e) {
      log("Copoun  Error $e");
      return null;
    }
  }
}
