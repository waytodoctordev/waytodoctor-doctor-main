import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/categories/categories_model.dart';
import 'package:way_to_doctor_doctor/model/registration/countries_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CenterCategories {
  static Future<CategoriesModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.centerCategories}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Countries Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Countries StatusCode:: ${response.statusCode}  Countries Body:: ${response.body}");
      CategoriesModel categoriesModel = CategoriesModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return categoriesModel;
      } else {
        throw "Categories  Error";
      }
    } catch (e) {
      log("Categories  Error $e");
      return null;
    }
  }
}
