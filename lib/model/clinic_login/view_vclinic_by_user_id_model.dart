// To parse this JSON data, do
//
//     final viewClinicByUserIdModel = viewClinicByUserIdModelFromJson(jsonString);

import 'dart:convert';

ViewClinicByUserIdModel viewClinicByUserIdModelFromJson(String str) =>
    ViewClinicByUserIdModel.fromJson(json.decode(str));

String viewClinicByUserIdModelToJson(ViewClinicByUserIdModel data) =>
    json.encode(data.toJson());

class ViewClinicByUserIdModel {
  ViewClinicByUserIdModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  bool status;
  int code;
  String msg;
  ClinicData data;

  factory ViewClinicByUserIdModel.fromJson(Map<String, dynamic> json) =>
      ViewClinicByUserIdModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: ClinicData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class ClinicData {
  ClinicData({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.lat,
    required this.long,
  });

  int id;
  String name;
  String phone;
  String address;
  double lat;
  double long;

  factory ClinicData.fromJson(Map<String, dynamic> json) => ClinicData(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "lat": lat,
        "long": long,
      };
}
