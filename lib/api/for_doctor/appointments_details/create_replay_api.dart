import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:way_to_doctor_doctor/model/create_replays_model/create_replays_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';
import 'package:path/path.dart';

class CreateReplayApi {
  static Future<CreateReplaysModel?> uploadRplay({
    File? file,
    required String content,
    required String date,
    required String appointmentId,
  }) async {
    try {
      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.createReplay}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };

      if (file != null) {
        var fileStream = http.ByteStream(file.openRead());
        var fileLength = await file.length();

        request.headers.addAll(headers);
        var multipartFile = http.MultipartFile("file", fileStream, fileLength,
            filename: basename(file.path));
        request.files.add(multipartFile);
      } else {}

      request.fields['content'] = content;
      request.fields['date'] = DateTime.now().toString();
      request.fields['appointment_id'] = appointmentId;

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        CreateReplaysModel createReplaysModel =
            CreateReplaysModel.fromJson(jsonData);
        return createReplaysModel;
      } else {
        throw "Create Replay Error";
      }
    } catch (e) {
      log("Create Replay Error $e");
      return null;
    }
  }
}
