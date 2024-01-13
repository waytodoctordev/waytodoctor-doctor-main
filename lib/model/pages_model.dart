// To parse this JSON data, do
//
//     final pageModel = pageModelFromJson(jsonString);

import 'dart:convert';

PageModel pageModelFromJson(String str) => PageModel.fromJson(json.decode(str));

String pageModelToJson(PageModel data) => json.encode(data.toJson());

class PageModel {
  PageModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  PageData? data;

  factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: PageData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class PageData {
  PageData({
    this.id,
    this.title,
    this.content,
  });

  int? id;
  String? title;
  String? content;

  factory PageData.fromJson(Map<String, dynamic> json) => PageData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
      };
}
