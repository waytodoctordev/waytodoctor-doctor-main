import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:get/get.dart';
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
    bool isEditCenterInfo=false
  }) async {
    try {
      print('EditCenterInfoApi isEditCenterInfo $isEditCenterInfo');
      var imageStream = http.ByteStream(imageProfile.openRead());
      var imageLength = await imageProfile.length();

      var uri = Uri.parse(
          "${ApiUrl.mainUrl}${ApiUrl.editCenterInfo}/${MySharedPreferences.userId}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
      'X-localization': MySharedPreferences.language,
    };
    request.headers.addAll(headers);
    var multipartImage = http.MultipartFile("image", imageStream, imageLength,
    filename: basename(imageProfile.path));


      if(!isEditCenterInfo){
          var fileStream =
          http.ByteStream(MySharedPreferences.professionalLicense.openRead());
          var fileLength = await MySharedPreferences.professionalLicense.length();
          var multipartFile = http.MultipartFile("license", fileStream, fileLength,
              filename: basename(MySharedPreferences.professionalLicense.path));
          request.files.add(multipartFile);
        }


    request.files.add(multipartImage);
      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['phone_number'] = phone;

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData =
            response.body; // await streamedResponse.stream.toBytes();

        // var responseString = String.fromCharCodes(responseData);
        // print(responseString);
        var jsonData = jsonDecode(responseData);
        EditCenterInfoModel editCenterInfo =
            EditCenterInfoModel.fromJson(jsonData);
        return editCenterInfo;
      }
    } catch (e) {
      log("Edit Center Info Error problem $e");
      Loader.hide();
      return null;
    }
  }
}
