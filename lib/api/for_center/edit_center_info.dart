import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import '../../model/center/edit_center_info_model.dart';

class EditCenterInfoApi {
  static Future<EditCenterInfoModel?> data(
      {required String phone,
      required String name,
      File? imageProfile,
      required String address,
      File? professionalLicense,
      bool isEditCenterInfo = false}) async {
    try {
      print('EditCenterInfoApi');
      var uri = Uri.parse(
          "${ApiUrl.mainUrl}${ApiUrl.editCenterInfo}/${MySharedPreferences.userId}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      if (imageProfile != null ) {
        print('imageProfile != null $imageProfile ');
        var imageStream = http.ByteStream(imageProfile.openRead());
        var imageLength = await imageProfile.length();
        var multipartImage = http.MultipartFile(
            "image", imageStream, imageLength,
            filename: basename(imageProfile.path));
        request.files.add(multipartImage);
      }
      if (!isEditCenterInfo && professionalLicense?.path !='') {
        print('hey nancy iam not null');
        var fileStream = http.ByteStream(
            MySharedPreferences.professionalLicense.openRead());
        var fileLength =
        await MySharedPreferences.professionalLicense.length();
        var multipartFile = http.MultipartFile(
            "license", fileStream, fileLength,
            filename: basename(MySharedPreferences.professionalLicense.path));
        request.files.add(multipartFile);
      }
      request.headers.addAll(headers);

      request.fields['name'] = name;
      request.fields['address'] = address;
      request.fields['phone_number'] = phone;

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        EditCenterInfoModel editCenterInfo =
            EditCenterInfoModel.fromJson(jsonData);
        Loader.hide();
        return editCenterInfo;
      }
    } catch (error) {
      log("Edit Center Info Error problem $error");
      Loader.hide();
      throw error.toString();
    }
    return null;
  }
}
