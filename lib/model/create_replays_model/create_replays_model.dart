// To parse this JSON data, do
//
//     final createReplaysModel = createReplaysModelFromJson(jsonString);

import 'dart:convert';

import 'package:way_to_doctor_doctor/model/doctor_descritption_model/doctor_descritption_model.dart';

CreateReplaysModel? createReplaysModelFromJson(String str) => CreateReplaysModel.fromJson(json.decode(str));

String createReplaysModelToJson(CreateReplaysModel? data) => json.encode(data!.toJson());

class CreateReplaysModel {
  CreateReplaysModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  ReplayData? data;

  factory CreateReplaysModel.fromJson(Map<String, dynamic> json) => CreateReplaysModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: ReplayData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}
