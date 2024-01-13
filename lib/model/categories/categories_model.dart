// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) => CategoriesModel.fromJson(json.decode(str));

class CategoriesModel {
  CategoriesModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<Categories>? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<Categories>.from(json["data"].map((x) => Categories.fromJson(x))),
      );
}

class Categories {
  Categories({
    this.id,
    this.name,
    this.image,
    this.type,
  });

  int? id;
  String? name;
  String? image;
  String? type;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
      );
}
