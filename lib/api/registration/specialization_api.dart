import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/create_certificate/create_certificate_mode.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import 'package:path/path.dart';

class SpecializationApi {
  static Future<CreateCertificateModel?> uploadPractice({
    required File image,
  }) async {
    try {
      var imageStream = http.ByteStream(image.openRead());
      var imageLength = await image.length();
      var fileStream = http.ByteStream(image.openRead());
      var fileLength = await image.length();
      var uri =
          Uri.parse("${ApiUrl.mainUrl}${ApiUrl.doctorCreateSpecialization}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      request.headers.addAll(headers);
      var multipartImage = http.MultipartFile("image", imageStream, imageLength,
          filename: basename(image.path));
      var multipartFile = http.MultipartFile("file", fileStream, fileLength,
          filename: basename(image.path));
      request.files.add(multipartImage);
      request.files.add(multipartFile);
      request.fields['title'] = MySharedPreferences.fName;
      request.fields['doctor_id'] = MySharedPreferences.id.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        CreateCertificateModel certificateModel =
            CreateCertificateModel.fromJson(jsonData);
        return certificateModel;
      } else {
        throw "Specialization Error";
      }
    } catch (e) {
      log("Specialization Error $e");
      return null;
    }
  }
}
