import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../../model/get_ratings/rating_model.dart';
import '../../../utils/api_url.dart';
import '../../../utils/shared_prefrences.dart';

class GetRatingsApi {
  static Future<RatingsModel?> data({
    required String doctorId,
    required int pageKey,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.getDoctorRatings}/$doctorId?page=$pageKey';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: RatingResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("RatingStatusCode:: ${response.statusCode}  RatingBody:: ${response.body}");
      RatingsModel ratingsModel =
          RatingsModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return ratingsModel;
      } else {
        throw "Rating Error";
      }
    } catch (e) {
      log("Rating Error $e");
      return null;
    }
  }
}
