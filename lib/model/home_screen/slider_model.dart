// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SlidersModel sliderModelFromJson(String str) => SlidersModel.fromJson(json.decode(str));

String sliderModelToJson(SlidersModel data) => json.encode(data.toJson());

class SlidersModel {
  SlidersModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<SlidersData>? data;

  factory SlidersModel.fromJson(Map<String, dynamic> json) => SlidersModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<SlidersData>.from(json["data"].map((x) => SlidersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SlidersData {
  SlidersData({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory SlidersData.fromJson(Map<String, dynamic> json) => SlidersData(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
