// To parse this JSON data, do
//
//     final otherDoctorsModel = otherDoctorsModelFromJson(jsonString);

import 'dart:convert';

OtherDoctorsModel otherDoctorsModelFromJson(String str) =>
    OtherDoctorsModel.fromJson(json.decode(str));

String otherDoctorsModelToJson(OtherDoctorsModel data) =>
    json.encode(data.toJson());

class OtherDoctorsModel {
  OtherDoctorsModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  List<OtherDoctorsData> data;

  factory OtherDoctorsModel.fromJson(Map<String, dynamic> json) =>
      OtherDoctorsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<OtherDoctorsData>.from(
            json["data"].map((x) => OtherDoctorsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OtherDoctorsData {
  OtherDoctorsData({
    required this.id,
    required this.name,
    required this.phone,
    required this.specialization,
    required this.user,
  });

  int id;
  String name;
  String phone;
  String specialization;
  int user;

  factory OtherDoctorsData.fromJson(Map<String, dynamic> json) =>
      OtherDoctorsData(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        specialization: json["specialization"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "specialization": specialization,
        "user": user,
      };
}
