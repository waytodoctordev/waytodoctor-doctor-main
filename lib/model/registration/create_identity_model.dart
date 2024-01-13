// To parse this JSON data, do
//
//     final identityModel = identityModelFromJson(jsonString);

import 'dart:convert';

IdentityModel identityModelFromJson(String str) => IdentityModel.fromJson(json.decode(str));

String identityModelToJson(IdentityModel data) => json.encode(data.toJson());

class IdentityModel {
  IdentityModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  Data? data;

  factory IdentityModel.fromJson(Map<String, dynamic> json) => IdentityModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.imageFront,
    this.imageBack,
    this.status,
    this.userId,
  });

  String? imageFront;
  String? imageBack;
  String? status;
  int? userId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        imageFront: json["image_front"],
        imageBack: json["image_back"],
        status: json["status"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_front": imageFront,
        "image_back": imageBack,
        "status": status,
        "user_id": userId,
      };
}
