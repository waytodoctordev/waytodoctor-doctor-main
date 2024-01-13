// To parse this JSON data, do
//
//     final createCertificateModel = createCertificateModelFromJson(jsonString);

import 'dart:convert';

CreateCertificateModel? createCertificateModelFromJson(String str) => CreateCertificateModel.fromJson(json.decode(str));

String createCertificateModelToJson(CreateCertificateModel? data) => json.encode(data!.toJson());

class CreateCertificateModel {
  CreateCertificateModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  CertificateData? data;

  factory CreateCertificateModel.fromJson(Map<String, dynamic> json) => CreateCertificateModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: CertificateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class CertificateData {
  CertificateData({
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

  factory CertificateData.fromJson(Map<String, dynamic> json) => CertificateData(
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
