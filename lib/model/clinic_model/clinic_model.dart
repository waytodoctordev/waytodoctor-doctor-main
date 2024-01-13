// To parse this JSON data, do
//
//     final clinicModel = clinicModelFromJson(jsonString);

import 'dart:convert';

ClinicModel? clinicModelFromJson(String str) => ClinicModel.fromJson(json.decode(str));

String clinicModelToJson(ClinicModel? data) => json.encode(data!.toJson());

class ClinicModel {
  ClinicModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  ClinicData? data;

  factory ClinicModel.fromJson(Map<String, dynamic> json) => ClinicModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: ClinicData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class ClinicData {
  ClinicData({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.userId,
    this.address,
    this.lat,
    this.long,
  });

  int? id;
  String? name;
  String? phone;
  String? email;
  int? userId;
  String? address;
  double? lat;
  double? long;

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        userId: json["user_id"],
        address: json["address"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "user_id": userId,
        "address": address,
        "lat": lat,
        "long": long,
      };
}
