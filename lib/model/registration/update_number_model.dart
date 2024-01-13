// To parse this JSON data, do
//
//     final updateNumberModel = updateNumberModelFromJson(jsonString);

import 'dart:convert';

UpdateNumberModel updateNumberModelFromJson(String str) =>
    UpdateNumberModel.fromJson(json.decode(str));

String updateNumberModelToJson(UpdateNumberModel data) =>
    json.encode(data.toJson());

class UpdateNumberModel {
  UpdateNumberModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  factory UpdateNumberModel.fromJson(Map<String, dynamic> json) =>
      UpdateNumberModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
      };
}
