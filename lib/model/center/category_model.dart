import 'dart:convert';

CenterCategoryModel welcomeFromJson(String str) => CenterCategoryModel.fromJson(json.decode(str));

String welcomeToJson(CenterCategoryModel data) => json.encode(data.toJson());

class CenterCategoryModel {
  bool status;
  int code;
  String msg;
  List<CenterCategory> data;

  CenterCategoryModel({
    required this.status,
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CenterCategoryModel.fromJson(Map<String, dynamic> json) => CenterCategoryModel(
    status: json["status"],
    code: json["code"],
    msg: json["msg"],
    data: List<CenterCategory>.from(json["data"].map((x) => CenterCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CenterCategory {
  int id;
  String name;
  String image;

  CenterCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CenterCategory.fromJson(Map<String, dynamic> json) => CenterCategory(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
