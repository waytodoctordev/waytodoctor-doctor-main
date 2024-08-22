import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/purchase_model/purchase_model.dart';

class PurchaseRequestApi {
  static Future<PurchasesModel?> data({
    required String startDate,
    required String userId,
    required String planId,
    required String receipt,
  }) async {
    try {
      print('PurchaseRequestApi ');
      String url = '${ApiUrl.mainUrl}${ApiUrl.applePurchase}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        'start_date': startDate,
        'receipt': receipt,
        'user_id':userId,
        'plan_id': planId,
      });

      // log("Response:: Appointments Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.post(uri, body: body, headers: headers);
      print(response.body);

      log("purchase StatusCode:: ${response.statusCode}  purchase Body:: ${response.body}");


      PurchasesModel purchasesModel = PurchasesModel.fromJson(json.decode(response.body));
      log("purchase orderNumber:: ${purchasesModel.data[0].orderNumber} ");
      if (response.statusCode == 200) {
        return purchasesModel;
      } else {
        throw "purchase PurchaseRequestApi";
      }
    } catch (e) {
      log("purchase PurchaseRequestApi $e");
      return null;
    }
  }
}
