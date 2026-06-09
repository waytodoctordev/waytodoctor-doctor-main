import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/plans_model/plans_model.dart';
import 'package:way_to_doctor_doctor/model/subscription_model/subscription_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class PlansApi {
  static Future<PlansModel?> plans() async {
    try {
      String url = MySharedPreferences.countryCode == '+962'
          ? '${ApiUrl.mainUrl}${ApiUrl.plansforJordan}'
          : '${ApiUrl.mainUrl}${ApiUrl.plansforOtherCountries}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };

      // log("Response:: Plans  Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Plans StatusCode:: ${response.statusCode}  Plans  Body:: ${response.body}");
      PlansModel plansModel = PlansModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return plansModel;
      } else {
        throw "Plans  Error";
      }
    } catch (e) {
      log("Plans  Error $e");
      return null;
    }
  }

  static Future<SubscriptionModel?> createSubscription({
    required String startDate,
    required String endDate,
    required String planId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.createSubscription}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "start_date": startDate,
        "end_date": endDate,
        "user_id": MySharedPreferences.userId,
        "plan_id": planId,
      });
      // log("Response:: Create subscription  Response\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Create subscription StatusCode:: ${response.statusCode}  Plans  Body:: ${response.body}");
      SubscriptionModel subscriptionModel =
          SubscriptionModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return subscriptionModel;
      } else {
        throw "Create subscription  Error";
      }
    } catch (e) {
      log("Create subscription  Error $e");
      return null;
    }
  }

  static Future<SubscriptionModel?> createSubscriptionforclinic({
    required String startDate,
    required String endDate,
    required String planId,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.createSubscription}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "start_date": startDate,
        "end_date": endDate,
        "user_id": MySharedPreferences.userId - 1,
        "plan_id": planId,
      });
      // log("Response:: Create subscription  Response\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Create subscription StatusCode:: ${response.statusCode}  Plans  Body:: ${response.body}");
      SubscriptionModel subscriptionModel =
          SubscriptionModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return subscriptionModel;
      } else {
        throw "Create subscription  Error";
      }
    } catch (e) {
      log("Create subscription  Error $e");
      return null;
    }
  }
}
