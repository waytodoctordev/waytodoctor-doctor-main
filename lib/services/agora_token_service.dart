import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

class GetAgoraToken {
  Future<String?> init(String channelName, BuildContext context) async {
    try {
      AppConstants.showLoading(context);
      String? token;
      String url = '${ApiUrl.mainUrl}token/$channelName/subscriber/12345';
      Uri uri = Uri.parse(url);
      Map<String, String>? headers = {};
      http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Loader.hide();
        token = jsonDecode(response.body)['token'];
        log("✅ Generated agora Token for vdieo call:: $token");
        return token;
      } else {
        throw "❌ Error Generated agora Token for vdieo call  Error";
      }
    } catch (e) {
      Loader.hide();
      log("❌ Error Generated agora Token for vdieo call  Error $e");
      return null;
    }
  }
}
