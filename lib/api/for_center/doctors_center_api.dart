import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../model/home_screen/doctors_model.dart';
import '../../utils/api_url.dart';
import '../../utils/shared_prefrences.dart';

class DoctorsCenterApi {
  static Future<CentersModel?> data({required int categoryId,required String search,required int centerId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.doctorsCenter}';
      // print(url);
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "value": search,
        "center_id":centerId ,
        "category_id":  categoryId,
      });
      http.Response response =
          await http.post(uri, headers: headers, body: body);
      // print(response.body);
      CentersModel doctorsCenterModel =
          CentersModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return doctorsCenterModel;
      } else if (response.statusCode == 500) {
        return doctorsCenterModel;
      } else {
        throw "doctors Centers Error";
      }
    } catch (e) {
      log("Doctors centers Error $e");
      return null;
    }
  }
}
