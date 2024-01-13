import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/center/category_centers.dart';
import '../../model/center/edit_center_info_model.dart';

class EditCenterInfoApi {
  static Future<EditCenterInfoModel?> data({
    required String phone,
    required String name,
    required File imageProfile,
    required String address,
    required File professionalLicense,
  }) async {
    try {
      var imageStream = http.ByteStream(imageProfile.openRead());
      var imageLength = await imageProfile.length();
      var fileStream = http.ByteStream(MySharedPreferences.professionalLicense.openRead());
      var fileLength = await MySharedPreferences.professionalLicense.length();

      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.editCenterInfo}/${MySharedPreferences.userId}");
// print('userId${MySharedPreferences.userId}');
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        // 'authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      request.headers.addAll(headers);
      // request.headers['authorization']='Bearer ${MySharedPreferences.accessToken}';

      var multipartImage = http.MultipartFile("image", imageStream, imageLength,
          filename: basename(imageProfile.path));
      var multipartFile = http.MultipartFile("license", fileStream, fileLength,
          filename: basename(MySharedPreferences.professionalLicense.path));
      request.files.add(multipartImage);
      request.files.add(multipartFile);
      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['phone_number'] = phone;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 200) {
        print('response.statusCode == 200');
        var responseData =response.body;// await streamedResponse.stream.toBytes();
        print(responseData);
        // var responseString = String.fromCharCodes(responseData);
        // print(responseString);
        var jsonData = jsonDecode(responseData);
        print(jsonData);
        EditCenterInfoModel editCenterInfo =
        EditCenterInfoModel.fromJson(jsonData);
        print(editCenterInfo.data?.name);
        return editCenterInfo;
      }


    } catch (e) {
      log("Edit Center Info Error problem $e");
      return null;
    }
  }
}
