// To parse this JSON data, do
//
//     final createStudiesModel = createStudiesModelFromJson(jsonString);

import 'dart:convert';

CreateStudiesModel? createStudiesModelFromJson(String str) =>
    CreateStudiesModel.fromJson(json.decode(str));

String createStudiesModelToJson(CreateStudiesModel? data) =>
    json.encode(data!.toJson());

class CreateStudiesModel {
  CreateStudiesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  StudiesData? data;

  factory CreateStudiesModel.fromJson(Map<String, dynamic> json) =>
      CreateStudiesModel(
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
    this.file,
    this.doctorId,
  });

  int? id;
  String? title;
  String? image;
  String? file;
  int? doctorId;

  factory StudiesData.fromJson(Map<String, dynamic> json) => StudiesData(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        file: json["file"],
        doctorId: json["doctor_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "file": file,
        "doctor_id": doctorId,
      };
}
