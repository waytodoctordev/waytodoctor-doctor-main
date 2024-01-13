import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/center/category_centers.dart';

class CategoryCentersApi {
  static Future<CategoryCenters?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.categoryCenters}/${MySharedPreferences.centerCategoryID}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: Countries Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("Countries StatusCode:: ${response.statusCode}  Countries Body:: ${response.body}");
      CategoryCenters categoriesModel = CategoryCenters.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return categoriesModel;
      } else {
        throw "Category Centers Error";
      }
    } catch (e) {
      log("Category Centers  $e");
      return null;
    }
  }
}
