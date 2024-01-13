// To parse this JSON data, do
//
//     final createPicturesModel = createPicturesModelFromJson(jsonString);

import 'dart:convert';

CreatePicturesModel? createPicturesModelFromJson(String str) =>
    CreatePicturesModel.fromJson(json.decode(str));

String createPicturesModelToJson(CreatePicturesModel? data) =>
    json.encode(data!.toJson());

class CreatePicturesModel {
  CreatePicturesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  StudiesData? data;

  factory CreatePicturesModel.fromJson(Map<String, dynamic> json) =>
      CreatePicturesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: StudiesData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class StudiesData {
  StudiesData({
    this.id,
    this.title,
    this.image,
    this.doctorId,
  });

  int? id;
  String? title;
  String? image;

  int? doctorId;

  factory StudiesData.fromJson(Map<String, dynamic> json) => StudiesData(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        doctorId: json["doctor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "doctor_id": doctorId,
      };
}
