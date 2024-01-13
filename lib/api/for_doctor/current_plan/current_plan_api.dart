import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/subscription_model/subscription_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class CurrentPlanApi {
  static Future<SubscriptionModel?> getCurrentplan(
      {required String subId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.getSubscrib}/$subId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };

      log("Response:: Curent Plan  Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Curent Plan StatusCode:: ${response.statusCode}  Curent Plan  Body:: ${response.body}");
      SubscriptionModel currentSubscriptionModel =
          SubscriptionModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return currentSubscriptionModel;
      } else {
        throw "Curent Plan  Error";
      }
    } catch (e) {
      log("Curent Plan  Error $e");
      return null;
    }
  }
}
