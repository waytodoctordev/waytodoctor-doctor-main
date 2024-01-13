// To parse this JSON data, do
//
//     final ratingModel = ratingModelFromJson(jsonString);

import 'dart:convert';

RatingsModel ratingModelFromJson(String str) =>
    RatingsModel.fromJson(json.decode(str));

String ratingModelToJson(RatingsModel data) => json.encode(data.toJson());

class RatingsModel {
  RatingsModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<RatingsDataModel>? data;

  factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: List<RatingsDataModel>.from(
            json["data"].map((x) => RatingsDataModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RatingsDataModel {
  RatingsDataModel({
    this.id,
    this.title,
    this.content,
    this.points,
    this.status,
  });

  int? id;
  String? title;
  String? content;
  double? points;
  int? status;

  factory RatingsDataModel.fromJson(Map<String, dynamic> json) =>
      RatingsDataModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        points: json["points"].toDouble(),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "points": points,
        "status": status,
      };
}
