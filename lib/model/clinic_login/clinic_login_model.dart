// To parse this JSON data, do
//
//     final clinicLoginModel = clinicLoginModelFromJson(jsonString);

import 'dart:convert';

import 'package:way_to_doctor_doctor/model/clinic_model/clinic_model.dart';

ClinicLoginModel? clinicLoginModelFromJson(String str) => ClinicLoginModel.fromJson(json.decode(str));

String clinicLoginModelToJson(ClinicLoginModel? data) => json.encode(data!.toJson());

class ClinicLoginModel {
  ClinicLoginModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  ClinicLoginData? data;

  factory ClinicLoginModel.fromJson(Map<String, dynamic> json) => ClinicLoginModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: ClinicLoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class ClinicLoginData {
  ClinicLoginData({
    this.token,
    this.clinic,
  });

  String? token;
  ClinicData? clinic;

  factory ClinicLoginData.fromJson(Map<String, dynamic> json) => ClinicLoginData(
        token: json["token"],
        clinic: ClinicData.fromJson(json["clinic"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "clinic": clinic!.toJson(),
      };
}
