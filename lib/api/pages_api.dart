import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/pages_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PagesApi {
  static Future<PageModel?> data({required String pageId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.pages}/$pageId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Page Model Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Page Model StatusCode:: ${response.statusCode} Page Model Body:: ${response.body}");
      PageModel pageModel = PageModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return pageModel;
      } else {
        throw "Page Model Error";
      }
    } catch (e) {
      log("Page Model Error $e");
      return null;
    }
  }
}
