// To parse this JSON data, do
//
//     final addCategoryModel = addCategoryModelFromJson(jsonString);

import 'dart:convert';

AddCategoryModel addCategoryModelFromJson(String str) =>
    AddCategoryModel.fromJson(json.decode(str));

String addCategoryModelToJson(AddCategoryModel data) =>
    json.encode(data.toJson());

class AddCategoryModel {
  AddCategoryModel({
    required this.status,
    required this.code,
    required this.msg,
  });

  bool status;
  int code;
  String msg;

  factory AddCategoryModel.fromJson(Map<String, dynamic> json) =>
      AddCategoryModel(
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
