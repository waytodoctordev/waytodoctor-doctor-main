import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

import '../model/transaction_model.dart';

class TransactionStatusApi {
  static Future<TransactionModel?> data({required String orderNumber}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.getTransaction}/$orderNumber';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Transaction Model Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Transaction Model StatusCode:: ${response.statusCode} Transaction Model Body:: ${response.body}");
      TransactionModel pageModel =
          TransactionModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return pageModel;
      } else {
        throw "Transaction Model Error";
      }
    } catch (e) {
      log("Transaction Model Error $e");
      return null;
    }
  }
}
