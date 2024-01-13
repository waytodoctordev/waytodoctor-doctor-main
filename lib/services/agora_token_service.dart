import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/utils/app_constants.dart';

class GetAgoraToken {
  Future<String?> init(String channelName, BuildContext context) async {
    try {
      AppConstants.showLoading(context);
      String? token;
      String url = 'https://token.waytodoctor.jo/access_token?channelName=$channelName&role=subscriber&uid=0';
      Uri uri = Uri.parse(url);
      Map<String, String>? headers = {};
      log("Response:: GetAgoraTokenResponse\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("GetAgoraTokenStatusCode:: ${response.statusCode} GetAgoraTokenBody:: ${response.body}");
      if (response.statusCode == 200) {
        Loader.hide();
        token = jsonDecode(response.body)['token'];
        log("GeneratedToken:: $token");
        return token;
      } else {
        throw "Doctor Login Error";
      }
    } catch (e) {
      Loader.hide();
      log("tokenError:: $e");
      return null;
    }
  }
}
