// To parse this JSON data, do
//
//     final DeleteModel = DeleteModelFromJson(jsonString);

import 'dart:convert';

DeleteModel deleteModelFromJson(String str) => DeleteModel.fromJson(json.decode(str));

String deleteModelToJson(DeleteModel data) => json.encode(data.toJson());

class DeleteModel {
  DeleteModel({
    this.status,
    this.code,
    this.msg,
  });

  bool? status;
  int? code;
  String? msg;

  factory DeleteModel.fromJson(Map<String, dynamic> json) => DeleteModel(
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
