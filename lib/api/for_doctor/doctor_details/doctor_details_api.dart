import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:way_to_doctor_doctor/model/create_payment/create_payment_mode.dart';
import 'package:way_to_doctor_doctor/model/create_studies/create_studies_mode.dart';
import 'package:way_to_doctor_doctor/model/delete_model.dart';
import 'package:way_to_doctor_doctor/utils/api_url.dart';

import '../../../model/create_pictures/create_pictures_mode.dart';
import '../../../model/doctor_model/doctor_model.dart';
import '../../../utils/shared_prefrences.dart';

class DoctorDetailsApi {
  static Future<DoctorDetailsModel?> data({required doctorId}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.getDoctorDetails}/$doctorId';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      // log("Response:: DoctorDetails Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      // log("DoctorDetails StatusCode:: ${response.statusCode}  DoctorBody:: ${response.body}");
      DoctorDetailsModel doctorDetailsModel =
          DoctorDetailsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return doctorDetailsModel;
      } else if (response.statusCode == 500) {
        return doctorDetailsModel;
      } else {
        throw "Doctor Error";
      }
    } catch (e) {
      log("Doctor Error $e");
      return null;
    }
  }

  Future<DoctorDetailsModel?> doctorExperience({
    required int experience,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "experience": experience,
      });
      log("Response:: Update Doctor Experince Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Update Doctor Experince StatusCode:: ${response.statusCode}  Update Doctor Experince Body:: ${response.body}");
      DoctorDetailsModel doctorExperince =
          DoctorDetailsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return doctorExperince;
      } else if (response.statusCode == 500) {
        return doctorExperince;
      } else {
        throw "Experince Error";
      }
    } catch (e) {
      log("Experince Error $e");
      return null;
    }
  }

  Future<DoctorDetailsModel?> doctorDescription({
    required String description,
  }) async {
    try {
      String url =
          '${ApiUrl.mainUrl}${ApiUrl.updateDoctorData}/${MySharedPreferences.id}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "description": description,
      });
      log("Response:: Update Doctor Description Response\nUrl:: $url\nheaders:: $headers\nbody:: $body");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Update Doctor Description StatusCode:: ${response.statusCode}  Update Doctor Description Body:: ${response.body}");
      DoctorDetailsModel doctorSecription =
          DoctorDetailsModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        return doctorSecription;
      } else if (response.statusCode == 500) {
        return doctorSecription;
      } else {
        throw "Description Error";
      }
    } catch (e) {
      log("Description Error $e");
      return null;
    }
  }

  static Future<DeleteModel?> deleteCertificate({required String id}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.deleteCertificate}/$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Delete Model Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Delete Model StatusCode:: ${response.statusCode} Delete Model Body:: ${response.body}");
      DeleteModel deleteCertificate =
          DeleteModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return deleteCertificate;
      } else {
        throw "Delete Model Error";
      }
    } catch (e) {
      log("Delete Model Error $e");
      return null;
    }
  }

  static Future<CreateStudiesModel?> createStudies({
    required File image,
  }) async {
    try {
      var imageStream = http.ByteStream(image.openRead());
      var imageLength = await image.length();
      var fileStream = http.ByteStream(image.openRead());
      var fileLength = await image.length();
      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.createStudies}");
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
        CreateStudiesModel createStudiesModel =
            CreateStudiesModel.fromJson(jsonData);
        return createStudiesModel;
      } else {
        throw "Create Studies Error";
      }
    } catch (e) {
      log("Create Studies Error $e");
      return null;
    }
  }

  static Future<DeleteModel?> deleteStudies({required String id}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.deleteStudies}/$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Delete Model Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Delete Model StatusCode:: ${response.statusCode} Delete Model Body:: ${response.body}");
      DeleteModel deleteCertificate =
          DeleteModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return deleteCertificate;
      } else {
        throw "Delete Model Error";
      }
    } catch (e) {
      log("Delete Model Error $e");
      return null;
    }
  }

  static Future<CreatePicturesModel?> createPictures({
    required File image,
  }) async {
    try {
      var imageStream = http.ByteStream(image.openRead());
      var imageLength = await image.length();

      var uri = Uri.parse("${ApiUrl.mainUrl}${ApiUrl.createPictures}");
      var request = http.MultipartRequest("POST", uri);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      request.headers.addAll(headers);
      var multipartImage = http.MultipartFile("image", imageStream, imageLength,
          filename: basename(image.path));

      request.files.add(multipartImage);

      request.fields['title'] = MySharedPreferences.fName;
      request.fields['doctor_id'] = MySharedPreferences.id.toString();

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        var jsonData = jsonDecode(responseString);
        CreatePicturesModel createPicturesModel =
            CreatePicturesModel.fromJson(jsonData);
        return createPicturesModel;
      } else {
        throw "Create Pics Error";
      }
    } catch (e) {
      log("Create Pics Error $e");
      return null;
    }
  }

  static Future<DeleteModel?> deletePictures({required String id}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.deletePictures}/$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Delete Model Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Delete Model StatusCode:: ${response.statusCode} Delete Model Body:: ${response.body}");
      DeleteModel deleteCertificate =
          DeleteModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return deleteCertificate;
      } else {
        throw "Delete Model Error";
      }
    } catch (e) {
      log("Delete Model Error $e");
      return null;
    }
  }

  static Future<CreatePaymentModel?> createPayment({
    required String name,
  }) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.createPayment}';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${MySharedPreferences.accessToken}',
        'X-localization': MySharedPreferences.language,
      };
      var body = jsonEncode({
        "name": name,
        "doctor_id": MySharedPreferences.id,
        // "phone": MySharedPreferences.userNumber,
      });
      log("Response:: Create Payment Response\nUrl:: $url\nheaders:: $headers");
      http.Response response =
          await http.post(uri, body: body, headers: headers);
      log("Create Payment StatusCode:: ${response.statusCode}  Create Payment Body:: ${response.body}");
      CreatePaymentModel createPaymentModel =
          CreatePaymentModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return createPaymentModel;
      } else {
        throw "Create Payment  Error";
      }
    } catch (e) {
      log("Create Payment  Error $e");
      return null;
    }
  }

  static Future<DeleteModel?> deletePyment({required String id}) async {
    try {
      String url = '${ApiUrl.mainUrl}${ApiUrl.deletePayment}/$id';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'X-localization': MySharedPreferences.language,
      };
      log("Response::Delete Model Response\nUrl:: $url\nheaders:: $headers");
      http.Response response = await http.get(uri, headers: headers);
      log("Delete Model StatusCode:: ${response.statusCode} Delete Model Body:: ${response.body}");
      DeleteModel deleteCertificate =
          DeleteModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        return deleteCertificate;
      } else {
        throw "Delete Model Error";
      }
    } catch (e) {
      log("Delete Model Error $e");
      return null;
    }
  }
}
