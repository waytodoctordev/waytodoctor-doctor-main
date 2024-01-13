import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/registration/update_number_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateNumberApi {
  Future<UpdateNumberModel?> data({
    required String phone,
    required String userID,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateUserNumber}/$userID';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": phone,
        'active': '2',
      });
      log("Response:: UpdateUserPhoneResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("UpdateUserPhoneStatusCode:: ${response.statusCode}  UpdateUserPhoneBody:: ${response.body}");
      UpdateNumberModel updateNumberModel =
          UpdateNumberModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return updateNumberModel;
      } else if (response.statusCode == 500) {
        return updateNumberModel;
      } else {
        throw "CheckOtp Error";
      }
    } catch (e) {
      log("CheckOtp Error $e");
      return null;
    }
  }

  Future<UpdateNumberModel?> doctorPhone({
    required String phone,
    required String userID,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/$userID';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "phone": phone,
        'active': '2',
      });
      log("Response:: UpdateUserPhoneResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("UpdateUserPhoneStatusCode:: ${response.statusCode}  UpdateUserPhoneBody:: ${response.body}");
      UpdateNumberModel updateNumberModel =
          UpdateNumberModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return updateNumberModel;
      } else if (response.statusCode == 500) {
        return updateNumberModel;
      } else {
        throw "CheckOtp Error";
      }
    } catch (e) {
      log("CheckOtp Error $e");
      return null;
    }
  }

  // Future<UpdateNumberModel?> clinicPhone({
  //   required String phone,
  //   required String userID,
  // }) async {
  //   try {
  //     String url = '${ApiUrl.mainUrl}${ApiUrl.updateUserNumber}/$userID';
  //     Uri uri = Uri.parse(url);
  //     var headers = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
  //       'X-localization': MySharedPreferences.language,
  //     };
  //     var body = jsonEncode({
  //       "phone": phone,
  //     });
  //     log("Response:: UpdateUserPhoneResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
  //     http.Response response =
  //         await http.post(uri, body: body, headers: headers);
  //     log("UpdateUserPhoneStatusCode:: ${response.statusCode}  UpdateUserPhoneBody:: ${response.body}");
  //     UpdateNumberModel updateNumberModel =
  //         UpdateNumberModel.fromJson(json.decode(response.body));
  //     if (response.statusCode == 200) {
  //       return updateNumberModel;
  //     } else if (response.statusCode == 500) {
  //       return updateNumberModel;
  //     } else {
  //       throw "CheckOtp Error";
  //     }
  //   } catch (e) {
  //     log("CheckOtp Error $e");
  //     return null;
  //   }
  // }
}
