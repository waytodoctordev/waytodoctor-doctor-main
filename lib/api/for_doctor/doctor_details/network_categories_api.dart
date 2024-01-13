import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../model/categories/add_doctor_to_category_model.dart';
import '../../../model/categories/categories_model.dart';
import '../../../utils/api_url.dart';
import '../../../utils/shared_prefrences.dart';

class NetworkCategoriesApi {
  static Future<CategoriesModel?> data() async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.categoriesByType}/network';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: CategoriesResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("CategoriesStatusCode:: ${response.statusCode}  CategoriesBody:: ${response.body}");
      CategoriesModel categoriesModel =
          CategoriesModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return categoriesModel;
      } else {
        throw "categories Error";
      }
    } catch (e) {
      log("categories Error $e");
      return null;
    }
  }

  static Future<AddCategoryModel?> addDoctorToCategory({
    required String catId,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.addCategoriestoDoctor}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "category_id": catId,
        // "category_id": MySharedPreferences.userNumber,
      });
      log("Response:: Add categoryResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Add categoryStatusCode:: ${response.statusCode}  Add categoryBody:: ${response.body}");
      AddCategoryModel addCategoryModel =
          AddCategoryModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return addCategoryModel;
      } else {
        throw "Add category Error";
      }
    } catch (e) {
      log("Add category Error $e");
      return null;
    }
  }
}
