// To parse this JSON data, do
//
//     final replaysModel = replaysModelFromJson(jsonString);

import 'dart:convert';

ReplaysModel? replaysModelFromJson(String str) => ReplaysModel.fromJson(json.decode(str));

String replaysModelToJson(ReplaysModel? data) => json.encode(data!.toJson());

class ReplaysModel {
  ReplaysModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  bool? status;
  int? code;
  String? msg;
  List<ReplayData>? data;

  factory ReplaysModel.fromJson(Map<String, dynamic> json) => ReplaysModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<ReplayData>.from(json["data"]!.map((x) => ReplayData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ReplayData {
  ReplayData({
    this.id,
    this.content,
    this.date,
    this.file,
    this.appointment,
  });

  int? id;
  String? content;
  DateTime? date;
  String? file;
  int? appointment;

  factory ReplayData.fromJson(Map<String, dynamic> json) => ReplayData(
        id: json["id"],
        content: json["content"],
        date: DateTime.parse(json["date"]),
        file: json["file"],
        appointment: json["appointment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "file": file,
        "appointment": appointment,
      };
}
