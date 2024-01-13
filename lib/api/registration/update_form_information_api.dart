import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:way_to_doctor_doctor/model/doctor_model/doctor_model.dart';
import 'package:way_to_doctor_doctor/model/user/user_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';
import 'package:way_to_doctor_doctor/utils/shared_prefrences.dart';

class UpdateUserDataApi {
  Future<UserModel?> updateData({
    required Map dataBody,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.updateUser}/${MySharedPreferences.userId}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode(dataBody);

      log("Response:: Update UserResponse\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response = await http.post(uri, body: body, headers: headers);
      // log("Update UserStatusCode:: ${response.statusCode}  Update UserBody:: ${response.body}");
      UserModel userModel = UserModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return userModel;
      } else if (response.statusCode == 500) {
        return userModel;
      } else {
        throw "Update User Error";
      }
    } catch (e) {
      log("Update User Error $e");
      return null;
    }
  }

  static Future<UserModel?> updateUserImage({
    required File profileImage,
  }) async {
    try {
      var profileImageStream = http.ByteStream(profileImage.openRead());
      var profileImageLength = await profileImage.length();

      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.updateUser}/${MySharedPreferences.userId}");
      var request = http.MultipartRequest("POST", uri);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };

      request.headers.addAll(headers);

      var multiprofileImageFile = http.MultipartFile('image', profileImageStream, profileImageLength, filename: basename(profileImage.path));

      request.files.add(multiprofileImageFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        UserModel userImageModel = UserModel.fromJson(jsonData);

        return userImageModel;
      } else {
        throw "Profile Image Model Error";
      }
    } catch (e) {
      log("Profile Image Model Error $e");
      return null;
    }
  }

  static Future<DoctorDetailsModel?> updateDoctorImage({
    required File profileImage,
  }) async {
    try {
      var profileImageStream = http.ByteStream(profileImage.openRead());
      var profileImageLength = await profileImage.length();

      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences.id}");
      var request = http.MultipartRequest("POST", uri);

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };

      request.headers.addAll(headers);

      var multiprofileImageFile = http.MultipartFile('image', profileImageStream, profileImageLength, filename: basename(profileImage.path));

      request.files.add(multiprofileImageFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        DoctorDetailsModel userImageModel = DoctorDetailsModel.fromJson(jsonData);

        return userImageModel;
      } else {
        throw "Profile Image Model Error";
      }
    } catch (e) {
      log("Profile Image Model Error $e");
      return null;
    }
  }
}
